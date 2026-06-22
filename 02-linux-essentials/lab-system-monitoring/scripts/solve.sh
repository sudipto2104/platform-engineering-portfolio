#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LAB_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"

echo "=== System Monitoring Lab — Solve ==="
mkdir -p "$LAB_DIR/deliverables" "$LAB_DIR/automation"

cp "$LAB_DIR/solutions/automation/taskflow-monitor.sh" "$LAB_DIR/automation/taskflow-monitor.sh"
chmod +x "$LAB_DIR/automation/taskflow-monitor.sh"
cp "$LAB_DIR/solutions/MONITORING_REPORT.md" "$LAB_DIR/deliverables/MONITORING_REPORT.md"

echo "→ Running taskflow-monitor.sh"
set +e
"$LAB_DIR/automation/taskflow-monitor.sh"
rc=$?
set -e
{
  echo ""
  echo "## Monitor run exit code: $rc ($(date -u +%Y-%m-%dT%H:%M:%SZ))"
} >> "$LAB_DIR/deliverables/MONITORING_REPORT.md"

echo "Run ./scripts/check.sh"