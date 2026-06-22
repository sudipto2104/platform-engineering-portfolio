#!/usr/bin/env bash
# Prototype: pre-deploy readiness gate for Apex / TaskFlow services.
set -euo pipefail

readonly SCRIPT_NAME="deploy-readiness-check"
readonly SERVICE_URL="${SERVICE_URL:-http://localhost:8080}"
readonly LOG_DIR="${LOG_DIR:-/tmp/apex-automation}"
readonly LOG_FILE="$LOG_DIR/${SCRIPT_NAME}.log"

mkdir -p "$LOG_DIR"

log() {
  echo "[$(date -u +%Y-%m-%dT%H:%M:%SZ)] [$SCRIPT_NAME] $*" | tee -a "$LOG_FILE"
}

checks_passed=0
checks_failed=0

run_check() {
  local name="$1"
  shift
  if "$@"; then
    log "PASS $name"
    checks_passed=$((checks_passed + 1))
  else
    log "FAIL $name"
    checks_failed=$((checks_failed + 1))
  fi
}

check_health() {
  curl -sf --max-time 5 "$SERVICE_URL/health" | grep -q '"status": "healthy"'
}

check_tasks_api() {
  curl -sf --max-time 5 "$SERVICE_URL/api/tasks" | grep -q '"count"'
}

check_docker_image() {
  docker image inspect taskflow:week1 &>/dev/null
}

resolve_taskflow_dir() {
  local base
  base="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
  for candidate in "$base/../../taskflow" "$base/../../../taskflow"; do
    if [[ -f "$candidate/app.py" ]]; then
      cd "$candidate" && pwd && return 0
    fi
  done
  return 1
}

check_git_repo() {
  local dir="${TASKFLOW_DIR:-$(resolve_taskflow_dir)}"
  [[ -d "$dir/.git" ]] && git -C "$dir" rev-parse HEAD &>/dev/null
}

log "INFO starting readiness checks for $SERVICE_URL"

run_check "health_endpoint" check_health
run_check "tasks_api" check_tasks_api
run_check "docker_image_present" check_docker_image || true
run_check "git_repository_ready" check_git_repo || true

log "INFO summary passed=$checks_passed failed=$checks_failed"
[[ "$checks_failed" -eq 0 ]]