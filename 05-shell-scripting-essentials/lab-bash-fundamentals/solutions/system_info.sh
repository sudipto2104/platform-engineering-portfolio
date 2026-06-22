#!/usr/bin/env bash
# Gather TaskFlow host system information
set -euo pipefail

HOST="$(hostname)"
UPTIME="$(uptime | sed 's/^.*up /up /')"
MEM="$(sysctl -n hw.memsize 2>/dev/null | awk '{printf "%.1f GB\n", $1/1073741824}' || free -h 2>/dev/null | awk '/Mem:/ {print $2}' || echo 'n/a')"
LOAD="$(uptime | awk -F'load averages?: ' '{print $2}' || echo 'n/a')"

printf '=== TaskFlow System Info ===\n'
printf 'Hostname: %s\n' "$HOST"
printf 'Uptime:   %s\n' "$UPTIME"
printf 'Memory:   %s\n' "$MEM"
printf 'Load:     %s\n' "$LOAD"
exit 0