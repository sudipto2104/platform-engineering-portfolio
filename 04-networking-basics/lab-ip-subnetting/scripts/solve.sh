#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LAB_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"

echo "=== IP Subnetting Lab — Solve ==="
mkdir -p "$LAB_DIR/deliverables"

cp "$LAB_DIR/solutions/SUBNET_DESIGN.md" "$LAB_DIR/deliverables/SUBNET_DESIGN.md"

python3 "$SCRIPT_DIR/subnet_calculator.py" 10.20.10.0/23 >> "$LAB_DIR/deliverables/SUBNET_DESIGN.md" 2>&1 || true
{
  echo ""
  echo "## Calculator output (10.20.10.0/23)"
  echo '```'
  python3 "$SCRIPT_DIR/subnet_calculator.py" 10.20.10.0/23
  echo '```'
} >> "$LAB_DIR/deliverables/SUBNET_DESIGN.md"

echo "Run ./scripts/check.sh"