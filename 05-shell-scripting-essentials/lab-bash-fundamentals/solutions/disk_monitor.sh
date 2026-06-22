#!/usr/bin/env bash
set -euo pipefail

THRESHOLD="${1:-80}"
MOUNT="${2:-/}"

USAGE="$(df -h "$MOUNT" | awk 'NR==2 {gsub(/%/,"",$5); print $5}')"
printf 'Disk usage on %s: %s%%\n' "$MOUNT" "$USAGE"

if [[ "$USAGE" -ge "$THRESHOLD" ]]; then
  echo "ALERT: usage ${USAGE}% >= threshold ${THRESHOLD}%" >&2
  exit 2
fi
exit 0