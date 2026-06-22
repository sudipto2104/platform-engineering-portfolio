#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LAB_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"

echo "=== Linux Security Lab — Solve ==="
mkdir -p "$LAB_DIR/deliverables"

"$LAB_DIR/solutions/apply-permissions.sh"
cp "$LAB_DIR/solutions/SECURITY_AUDIT.md" "$LAB_DIR/deliverables/SECURITY_AUDIT.md"
echo "→ deliverables/SECURITY_AUDIT.md"
echo "Run ./scripts/check.sh"