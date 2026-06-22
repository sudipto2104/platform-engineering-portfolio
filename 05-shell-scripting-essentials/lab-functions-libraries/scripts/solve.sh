#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LAB_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
DELIV="$LAB_DIR/deliverables"

echo "=== Functions & Libraries Lab — Solve ==="
mkdir -p "$DELIV/lib"

cp "$LAB_DIR/lib/"*.sh "$DELIV/lib/"
cp "$LAB_DIR/solutions/deploy_module.sh" "$DELIV/deploy_module.sh"
cp "$LAB_DIR/solutions/FUNCTIONS_GUIDE.md" "$DELIV/FUNCTIONS_GUIDE.md"
chmod +x "$DELIV/deploy_module.sh" "$DELIV/lib/"*.sh

"$DELIV/deploy_module.sh" dev > "$DELIV/deploy_report.txt" 2>&1

echo "→ deliverables/deploy_module.sh + lib/"
echo "Run ./scripts/check.sh"