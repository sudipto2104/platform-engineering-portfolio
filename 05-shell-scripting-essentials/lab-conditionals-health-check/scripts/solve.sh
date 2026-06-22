#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LAB_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
DELIV="$LAB_DIR/deliverables"

echo "=== Conditionals Health Check Lab — Solve ==="
mkdir -p "$DELIV"

cp "$LAB_DIR/solutions/health_check.sh" "$DELIV/health_check.sh"
cp "$LAB_DIR/solutions/HEALTH_CHECK_GUIDE.md" "$DELIV/HEALTH_CHECK_GUIDE.md"
chmod +x "$DELIV/health_check.sh"

BATCH_MODE=1 "$DELIV/health_check.sh" "$LAB_DIR/workspace/thresholds.env" \
  > "$DELIV/health_report.txt" 2>&1 || true

echo "→ deliverables/health_check.sh"
echo "Run ./scripts/check.sh"