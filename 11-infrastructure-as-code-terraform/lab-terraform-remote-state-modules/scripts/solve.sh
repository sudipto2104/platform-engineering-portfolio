#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LAB_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
DELIV="$LAB_DIR/deliverables"

echo "=== Remote State & Modules Lab — Solve ==="
mkdir -p "$DELIV"
cp -R "$LAB_DIR/solutions/bootstrap" "$LAB_DIR/solutions/modules" "$LAB_DIR/solutions/environments" "$DELIV/"
cp "$LAB_DIR/solutions/REMOTE_STATE_GUIDE.md" "$DELIV/"

if command -v terraform &>/dev/null; then
  find "$DELIV" -name '*.tf' -exec dirname {} \; | sort -u | while read -r d; do
    (cd "$d" && terraform fmt -recursive 2>/dev/null) || true
  done
fi

echo "→ deliverables/modules/, environments/, bootstrap/"
echo "Run ./scripts/check.sh"