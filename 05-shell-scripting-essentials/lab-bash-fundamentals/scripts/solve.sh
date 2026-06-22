#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LAB_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
DELIV="$LAB_DIR/deliverables"

echo "=== Bash Fundamentals Lab — Solve ==="
mkdir -p "$DELIV"

for script in backup_files.sh rotate_logs.sh system_info.sh disk_monitor.sh cleanup_temp.sh; do
  cp "$LAB_DIR/solutions/$script" "$DELIV/$script"
  chmod +x "$DELIV/$script"
done

mkdir -p "$LAB_DIR/workspace/tmp"
echo "stale" > "$LAB_DIR/workspace/tmp/old-file.txt"
touch -t 202401010000 "$LAB_DIR/workspace/tmp/old-file.txt" 2>/dev/null || true

"$DELIV/system_info.sh" > "$DELIV/system_info_report.txt"
"$DELIV/disk_monitor.sh" 99 / > "$DELIV/disk_report.txt" 2>&1 || true
"$DELIV/backup_files.sh" "$LAB_DIR/workspace/app" "$DELIV/backups" > "$DELIV/backup_report.txt"

echo "→ deliverables/*.sh + reports"
echo "Run ./scripts/check.sh"