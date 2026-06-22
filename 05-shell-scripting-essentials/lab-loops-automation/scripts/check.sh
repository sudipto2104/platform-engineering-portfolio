#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LAB_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
DELIV="$LAB_DIR/deliverables"

PASS=0; FAIL=0
pass() { echo "✓ $1"; PASS=$((PASS+1)); }
fail() { echo "✗ $1"; FAIL=$((FAIL+1)); }

echo "=== Loops Automation Lab — Check ==="

[[ -x "$DELIV/batch_automation.sh" ]] && pass "batch_automation.sh" || fail "batch_automation.sh"
grep -q 'for host' "$DELIV/batch_automation.sh" && pass "for loop" || fail "for loop"
grep -q 'while IFS' "$DELIV/batch_automation.sh" && pass "while loop" || fail "while loop"
grep -q 'until ' "$DELIV/batch_automation.sh" && pass "until loop" || fail "until loop"
grep -q 'servers\[@\]' "$DELIV/batch_automation.sh" && pass "Arrays" || fail "Arrays"
grep -q 'rotate_backups\|multi_env' "$DELIV/batch_automation.sh" && pass "Batch patterns" || fail "Batch patterns"

[[ -f "$DELIV/batch_report.txt" ]] && pass "Batch report" || fail "Batch report"
grep -q 'DEPLOY\|Pipeline' "$DELIV/batch_report.txt" && pass "Deploy output" || fail "Deploy output"

echo "Results: $PASS passed, $FAIL failed"
[[ "$FAIL" -eq 0 ]] || { echo "Run ./scripts/solve.sh"; exit 1; }