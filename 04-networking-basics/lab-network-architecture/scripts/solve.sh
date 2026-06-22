#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LAB_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"

echo "=== Network Architecture Lab — Solve ==="
mkdir -p "$LAB_DIR/deliverables/environments"

cp "$LAB_DIR/solutions/ARCHITECTURE_DECISIONS.md" "$LAB_DIR/deliverables/ARCHITECTURE_DECISIONS.md"
cp "$LAB_DIR/solutions/environments/"*.yaml "$LAB_DIR/deliverables/environments/"

echo "→ deliverables/environments/{dev,staging,production}.yaml"
echo "→ deliverables/ARCHITECTURE_DECISIONS.md"
echo "Run ./scripts/check.sh"