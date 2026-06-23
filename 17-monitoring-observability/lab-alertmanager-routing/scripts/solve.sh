#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LAB_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
DELIV="$LAB_DIR/deliverables"
SRC="$LAB_DIR/solutions"

echo "=== AlertManager Routing Lab — Solve ==="
mkdir -p "$DELIV/alertmanager" "$DELIV/prometheus"
cp "$SRC/ALERTMANAGER_GUIDE.md" "$DELIV/"
cp "$SRC/alertmanager/"*.yml "$DELIV/alertmanager/"
cp "$SRC/prometheus/"*.yml "$DELIV/prometheus/"

echo "→ deliverables/alertmanager/, prometheus/"
echo "Run ./scripts/check.sh"