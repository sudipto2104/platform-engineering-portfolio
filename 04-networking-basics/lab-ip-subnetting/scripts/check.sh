#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LAB_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
DELIV="$LAB_DIR/deliverables/SUBNET_DESIGN.md"

PASS=0; FAIL=0
pass() { echo "✓ $1"; PASS=$((PASS+1)); }
fail() { echo "✗ $1"; FAIL=$((FAIL+1)); }

echo "=== IP Subnetting Lab — Check ==="

[[ -f "$DELIV" ]] && pass "SUBNET_DESIGN.md" || fail "SUBNET_DESIGN.md"
grep -qiE "CIDR|10\.(10|20|30)|subnet|VPC" "$DELIV" && pass "VPC allocations" || fail "VPC content"
grep -qiE "public|private|web|app|database|data" "$DELIV" && pass "Multi-tier subnets" || fail "Tier design"
[[ -x "$SCRIPT_DIR/subnet_calculator.py" ]] && pass "Subnet calculator" || fail "Subnet calculator"

python3 "$SCRIPT_DIR/subnet_calculator.py" 10.20.1.0/24 | grep -q "Usable hosts" \
  && pass "Calculator runs" || fail "Calculator runs"

echo "Results: $PASS passed, $FAIL failed"
[[ "$FAIL" -eq 0 ]] || { echo "Run ./scripts/solve.sh"; exit 1; }