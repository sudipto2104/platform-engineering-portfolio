#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LAB_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
DELIV="$LAB_DIR/deliverables"
SRC="$LAB_DIR/solutions"

echo "=== Backstage Service Catalog Lab — Solve ==="
mkdir -p "$DELIV/catalog" "$DELIV/workspace"
cp "$SRC/BACKSTAGE_CATALOG_GUIDE.md" "$SRC/REACT_VS_VUE.md" "$DELIV/"
cp "$SRC/workspace/app-config.yaml" "$DELIV/workspace/"
cp "$SRC/catalog/"*.yaml "$DELIV/catalog/"

echo "→ deliverables/catalog/, workspace/app-config.yaml"
echo "Run ./scripts/check.sh"