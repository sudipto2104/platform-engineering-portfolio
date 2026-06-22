#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LAB_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"

echo "=== Server Configuration Lab — Solve ==="
mkdir -p "$LAB_DIR/deliverables"
cp "$LAB_DIR/solutions/SERVER_BASELINE.md" "$LAB_DIR/deliverables/SERVER_BASELINE.md"
echo "→ deliverables/SERVER_BASELINE.md"
echo "Apply exercises/SERVER_SETUP.md on your Ubuntu VM."
echo "Run ./scripts/check.sh"