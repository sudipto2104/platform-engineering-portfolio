#!/usr/bin/env bash
# Idempotent TaskFlow local development setup.
set -euo pipefail

readonly SCRIPT_NAME="taskflow-setup"
_resolve_taskflow_dir() {
  local base
  base="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
  for candidate in "$base/../../taskflow" "$base/../../../taskflow"; do
    if [[ -f "$candidate/requirements.txt" ]]; then
      cd "$candidate" && pwd && return 0
    fi
  done
  return 1
}
readonly TASKFLOW_DIR="${TASKFLOW_DIR:-$(_resolve_taskflow_dir)}"
readonly VENV_DIR="${VENV_DIR:-$TASKFLOW_DIR/.venv}"
readonly LOG_DIR="${LOG_DIR:-/tmp/taskflow-automation}"
readonly LOG_FILE="$LOG_DIR/${SCRIPT_NAME}.log"

mkdir -p "$LOG_DIR"

log() {
  local level="$1"; shift
  echo "[$(date -u +%Y-%m-%dT%H:%M:%SZ)] [$level] $SCRIPT_NAME: $*" | tee -a "$LOG_FILE"
}

die() { log "ERROR" "$*"; exit 1; }

log "INFO" "Starting setup (TASKFLOW_DIR=$TASKFLOW_DIR)"

command -v python3 &>/dev/null || die "python3 not found"

[[ -f "$TASKFLOW_DIR/requirements.txt" ]] || die "requirements.txt missing in $TASKFLOW_DIR"

# Idempotent venv creation
if [[ ! -d "$VENV_DIR" ]]; then
  log "INFO" "Creating virtualenv at $VENV_DIR"
  python3 -m venv "$VENV_DIR"
else
  log "INFO" "Virtualenv already exists — skipping create"
fi

# shellcheck source=/dev/null
source "$VENV_DIR/bin/activate"

log "INFO" "Installing dependencies"
pip install -q -r "$TASKFLOW_DIR/requirements.txt"

# Idempotent verify — import check without starting server
python3 -c "import flask; print(flask.__version__)" >>"$LOG_FILE" 2>&1 \
  || die "Flask import failed after install"

log "INFO" "Setup complete. Activate with: source $VENV_DIR/bin/activate"
log "INFO" "Start app: python $TASKFLOW_DIR/app.py"
exit 0