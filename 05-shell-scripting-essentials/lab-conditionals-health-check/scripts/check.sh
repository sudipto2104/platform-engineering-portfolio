#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LAB_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
DELIV="$LAB_DIR/deliverables"

PASS=0; FAIL=0
pass() { echo "✓ $1"; PASS=$((PASS+1)); }
fail() { echo "✗ $1"; FAIL=$((FAIL+1)); }

echo "=== Conditionals Health Check Lab — Check ==="

[[ -x "$DELIV/health_check.sh" ]] && pass "health_check.sh" || fail "health_check.sh"
grep -q 'elif' "$DELIV/health_check.sh" && pass "elif branches" || fail "elif"
grep -q 'case ' "$DELIV/health_check.sh" && pass "case statement" || fail "case"
grep -qE '\-e|\-r|\-f' "$DELIV/health_check.sh" && pass "File tests" || fail "File tests"
grep -q 'command -v' "$DELIV/health_check.sh" && pass "Binary validation" || fail "Binary validation"

[[ -f "$DELIV/HEALTH_CHECK_GUIDE.md" ]] && pass "Guide" || fail "Guide"
[[ -f "$DELIV/health_report.txt" ]] && pass "Health report" || fail "Health report"

echo "Results: $PASS passed, $FAIL failed"
[[ "$FAIL" -eq 0 ]] || { echo "Run ./scripts/solve.sh"; exit 1; }