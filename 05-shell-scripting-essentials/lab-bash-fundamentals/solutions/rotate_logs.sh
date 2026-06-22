#!/usr/bin/env bash
set -euo pipefail

LOG_DIR="${1:-./logs}"
KEEP_DAYS="${2:-7}"

if [[ ! -d "$LOG_DIR" ]]; then
  echo "Log directory not found: $LOG_DIR" >&2
  exit 1
fi

shopt -s nullglob
for log in "$LOG_DIR"/*.log; do
  gzip -f "$log"
  echo "Rotated: $log"
done

find "$LOG_DIR" -name '*.log.gz' -mtime +"$KEEP_DAYS" -delete 2>/dev/null || true
echo "Retention: ${KEEP_DAYS} days"
exit 0