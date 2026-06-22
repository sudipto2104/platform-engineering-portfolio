#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LAB_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"

echo "=== Linux Commands Lab — Solve ==="
mkdir -p "$LAB_DIR/deliverables"

cp "$LAB_DIR/solutions/COMMAND_PRACTICE_LOG.md" "$LAB_DIR/deliverables/COMMAND_PRACTICE_LOG.md"
echo "→ deliverables/COMMAND_PRACTICE_LOG.md"

# Generate live stats into deliverable
LOG="$LAB_DIR/../taskflow-workspace/logs/taskflow.log"
{
  echo ""
  echo "## Live workspace stats (generated $(date -u +%Y-%m-%dT%H:%M:%SZ))"
  echo "- Log lines: $(wc -l < "$LOG" | tr -d ' ')"
  echo "- ERROR count: $(grep -c ERROR "$LOG" || true)"
  echo "- WARN count: $(grep -c WARN "$LOG" || true)"
} >> "$LAB_DIR/deliverables/COMMAND_PRACTICE_LOG.md"

echo "Run ./scripts/check.sh"