#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LAB_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
DELIV="$LAB_DIR/deliverables"

echo "=== Loops Automation Lab — Solve ==="
mkdir -p "$DELIV"

cp "$LAB_DIR/solutions/batch_automation.sh" "$DELIV/batch_automation.sh"
cp "$LAB_DIR/solutions/LOOPS_GUIDE.md" "$DELIV/LOOPS_GUIDE.md"
chmod +x "$DELIV/batch_automation.sh"

WORKSPACE="$LAB_DIR/workspace" "$DELIV/batch_automation.sh" all \
  > "$DELIV/batch_report.txt" 2>&1

echo "→ deliverables/batch_automation.sh"
echo "Run ./scripts/check.sh"