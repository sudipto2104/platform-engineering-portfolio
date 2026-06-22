#!/usr/bin/env bash
# TaskFlow health probe with structured logging and exit codes.
# Exit 0 = healthy, 1 = unhealthy, 2 = misconfiguration
set -euo pipefail

readonly SCRIPT_NAME="taskflow-health"
readonly BASE_URL="${TASKFLOW_BASE_URL:-http://localhost:8080}"
readonly TIMEOUT="${CURL_TIMEOUT:-5}"
readonly LOG_DIR="${LOG_DIR:-/tmp/taskflow-automation}"
readonly LOG_FILE="$LOG_DIR/${SCRIPT_NAME}.log"

mkdir -p "$LOG_DIR"

log() {
  local level="$1"; shift
  echo "[$(date -u +%Y-%m-%dT%H:%M:%SZ)] [$level] $SCRIPT_NAME: $*" | tee -a "$LOG_FILE"
}

command -v curl &>/dev/null || { log "ERROR" "curl required"; exit 2; }
command -v python3 &>/dev/null || { log "ERROR" "python3 required"; exit 2; }

log "INFO" "Probing $BASE_URL/health"

response=$(curl -sf --max-time "$TIMEOUT" "$BASE_URL/health" 2>/dev/null) || {
  log "ERROR" "Health endpoint unreachable at $BASE_URL/health"
  exit 1
}

status=$(echo "$response" | python3 -c "import sys,json; print(json.load(sys.stdin).get('status',''))" 2>/dev/null) || {
  log "ERROR" "Invalid JSON from health endpoint"
  exit 1
}

if [[ "$status" != "healthy" ]]; then
  log "ERROR" "Unexpected status: $status"
  exit 1
fi

version=$(echo "$response" | python3 -c "import sys,json; print(json.load(sys.stdin).get('version','unknown'))")
log "INFO" "Healthy — service=taskflow version=$version"
exit 0