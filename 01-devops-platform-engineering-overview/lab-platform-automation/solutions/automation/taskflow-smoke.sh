#!/usr/bin/env bash
# TaskFlow API smoke tests — supports single instance or Terraform replicas.
set -euo pipefail

readonly SCRIPT_NAME="taskflow-smoke"
readonly BASE_URL="${TASKFLOW_BASE_URL:-http://localhost:8080}"
readonly REPLICA_PORTS="${TASKFLOW_REPLICA_PORTS:-9080 9081 9082}"
readonly LOG_DIR="${LOG_DIR:-/tmp/taskflow-automation}"
readonly LOG_FILE="$LOG_DIR/${SCRIPT_NAME}.log"

mkdir -p "$LOG_DIR"

log() {
  local level="$1"; shift
  echo "[$(date -u +%Y-%m-%dT%H:%M:%SZ)] [$level] $SCRIPT_NAME: $*" | tee -a "$LOG_FILE"
}

probe_url() {
  local url="$1"
  local label="$2"

  log "INFO" "Smoke testing $label ($url)"

  curl -sf --max-time 5 "$url/health" >/dev/null \
    || { log "ERROR" "$label health failed"; return 1; }

  local count
  count=$(curl -sf --max-time 5 "$url/api/tasks" \
    | python3 -c "import sys,json; print(json.load(sys.stdin).get('count',0))" 2>/dev/null) \
    || { log "ERROR" "$label /api/tasks failed"; return 1; }

  if [[ "$count" -lt 1 ]]; then
    log "ERROR" "$label returned count=$count"
    return 1
  fi

  log "INFO" "$label OK (tasks=$count)"
  return 0
}

FAIL=0

# Primary URL
probe_url "$BASE_URL" "primary" || FAIL=$((FAIL + 1))

# Replica ports (idempotent — skip if not running)
for port in $REPLICA_PORTS; do
  if curl -sf --max-time 2 "http://localhost:${port}/health" >/dev/null 2>&1; then
    probe_url "http://localhost:${port}" "replica:${port}" || FAIL=$((FAIL + 1))
  else
    log "INFO" "replica:${port} not running — skipped"
  fi
done

if [[ "$FAIL" -gt 0 ]]; then
  log "ERROR" "Smoke tests failed ($FAIL errors)"
  exit 1
fi

log "INFO" "All smoke tests passed"
exit 0