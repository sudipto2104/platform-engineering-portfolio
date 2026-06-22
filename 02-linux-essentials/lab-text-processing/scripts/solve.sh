#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LAB_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"

echo "=== Text Processing Lab — Solve ==="
mkdir -p "$LAB_DIR/deliverables" "$LAB_DIR/automation"

cp "$LAB_DIR/solutions/automation/analyze-taskflow-logs.sh" "$LAB_DIR/automation/analyze-taskflow-logs.sh"
chmod +x "$LAB_DIR/automation/analyze-taskflow-logs.sh"

DELIV="$LAB_DIR/deliverables/LOG_SUMMARY.md"
"$LAB_DIR/automation/analyze-taskflow-logs.sh" \
  "$LAB_DIR/../taskflow-workspace/logs/taskflow.log" \
  "$DELIV"

echo "→ $DELIV"
echo "Run ./scripts/check.sh"