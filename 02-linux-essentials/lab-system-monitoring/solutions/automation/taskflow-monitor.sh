#!/usr/bin/env bash
# TaskFlow host monitoring — threshold alerts (Week 2 → Week 17 Prometheus path).
set -euo pipefail

readonly SCRIPT_NAME="taskflow-monitor"
readonly LOG_DIR="${LOG_DIR:-/tmp/taskflow-monitor}"
readonly LOG_FILE="$LOG_DIR/${SCRIPT_NAME}.log"
_resolve_log() {
  local base
  base="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
  for candidate in "$base/../../taskflow-workspace/logs/taskflow.log" "$base/../../../taskflow-workspace/logs/taskflow.log"; do
    [[ -f "$candidate" ]] && echo "$candidate" && return 0
  done
  echo "$base/../../taskflow-workspace/logs/taskflow.log"
}
readonly APP_LOG="${APP_LOG:-$(_resolve_log)}"

DISK_WARN="${DISK_WARN:-85}"
MEM_WARN="${MEM_WARN:-90}"
ERROR_BURST="${ERROR_BURST:-3}"

mkdir -p "$LOG_DIR"
ALERTS=0

log() {
  echo "[$(date -u +%Y-%m-%dT%H:%M:%SZ)] [$SCRIPT_NAME] $*" | tee -a "$LOG_FILE"
}

alert() { log "ALERT $*"; ALERTS=$((ALERTS + 1)); }
ok() { log "OK $*"; }

# Disk (df)
if command -v df &>/dev/null; then
  while read -r pct mount; do
    pct_num=${pct%\%}
    if [[ "$pct_num" -ge "$DISK_WARN" ]]; then
      alert "disk ${mount} at ${pct} (threshold ${DISK_WARN}%)"
    else
      ok "disk ${mount} at ${pct}"
    fi
  done < <(df -H / 2>/dev/null | awk 'NR>1 {print $5, $NF}')
else
  log "WARN df not available"
fi

# Memory (free - portable awk)
if command -v free &>/dev/null; then
  mem_pct=$(free | awk '/Mem:/ {printf "%d", $3/$2 * 100}')
  if [[ "$mem_pct" -ge "$MEM_WARN" ]]; then
    alert "memory at ${mem_pct}% (threshold ${MEM_WARN}%)"
  else
    ok "memory at ${mem_pct}%"
  fi
elif [[ "$(uname -s)" == "Darwin" ]]; then
  ok "memory check skipped on macOS (use VM for free)"
fi

# Log analysis — ERROR burst in last 50 lines
if [[ -f "$APP_LOG" ]]; then
  errors=$(tail -50 "$APP_LOG" | grep -c ERROR || true)
  warns=$(tail -50 "$APP_LOG" | grep -c WARN || true)
  ok "log tail errors=$errors warns=$warns (file=$APP_LOG)"
  if [[ "$errors" -ge "$ERROR_BURST" ]]; then
    alert "error burst: $errors ERROR lines in last 50 log entries"
  fi
  # Simulate log-based disk warning from sample data
  if grep -q 'disk_usage' "$APP_LOG" && grep 'disk_usage' "$APP_LOG" | tail -1 | grep -qE 'percent=8[0-9]'; then
    alert "application logged high disk usage — see taskflow.log"
  fi
else
  alert "app log missing: $APP_LOG"
fi

# Process spot-check (ps)
if pgrep -f "gunicorn.*app:app" &>/dev/null || pgrep -f "python.*app.py" &>/dev/null; then
  ok "TaskFlow process running"
else
  ok "TaskFlow process not running (expected if not started)"
fi

log "INFO summary alerts=$ALERTS"
[[ "$ALERTS" -eq 0 ]]