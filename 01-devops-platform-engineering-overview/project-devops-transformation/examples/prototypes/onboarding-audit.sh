#!/usr/bin/env bash
# Prototype: audit whether a workstation meets TaskFlow / Apex onboarding bar.
set -euo pipefail

readonly SCRIPT_NAME="onboarding-audit"
readonly LOG_DIR="${LOG_DIR:-/tmp/apex-automation}"
readonly LOG_FILE="$LOG_DIR/${SCRIPT_NAME}.log"

mkdir -p "$LOG_DIR"

log() {
  echo "[$(date -u +%Y-%m-%dT%H:%M:%SZ)] [$SCRIPT_NAME] $*" | tee -a "$LOG_FILE"
}

score=0
max=0

audit() {
  local label="$1"
  shift
  max=$((max + 1))
  if "$@"; then
    log "PASS $label"
    score=$((score + 1))
  else
    log "FAIL $label"
  fi
}

audit "git_installed" command -v git
audit "docker_installed" command -v docker
audit "python3_installed" command -v python3
audit "git_user_name" bash -c '[[ -n "$(git config --global user.name 2>/dev/null)" ]]'
audit "git_user_email" bash -c '[[ -n "$(git config --global user.email 2>/dev/null)" ]]'

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

TASKFLOW_DIR="${TASKFLOW_DIR:-$(resolve_taskflow_dir)}"
audit "taskflow_app_present" test -f "$TASKFLOW_DIR/app.py"
audit "taskflow_requirements" test -f "$TASKFLOW_DIR/requirements.txt"

pct=$((score * 100 / max))
log "INFO onboarding score ${score}/${max} (${pct}%)"

[[ "$pct" -ge 70 ]]