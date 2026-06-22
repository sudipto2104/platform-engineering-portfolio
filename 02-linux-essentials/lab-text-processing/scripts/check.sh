#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LAB_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"

PASS=0; FAIL=0
pass() { echo "✓ $1"; PASS=$((PASS+1)); }
fail() { echo "✗ $1"; FAIL=$((FAIL+1)); }

echo "=== Text Processing Lab — Check ==="

[[ -x "$LAB_DIR/automation/analyze-taskflow-logs.sh" ]] && pass "Analysis script" || fail "Analysis script"
grep -q awk "$LAB_DIR/automation/analyze-taskflow-logs.sh" && pass "Uses awk" || fail "awk"
grep -q sed "$LAB_DIR/automation/analyze-taskflow-logs.sh" && pass "Uses sed" || fail "sed"
grep -q grep "$LAB_DIR/automation/analyze-taskflow-logs.sh" && pass "Uses grep" || fail "grep"

[[ -f "$LAB_DIR/deliverables/LOG_SUMMARY.md" ]] && pass "LOG_SUMMARY.md" || fail "LOG_SUMMARY"
grep -qiE 'ERROR|WARN|duration|endpoint' "$LAB_DIR/deliverables/LOG_SUMMARY.md" \
  && pass "Summary has parsed metrics" || fail "Summary content"

echo "Results: $PASS passed, $FAIL failed"
[[ "$FAIL" -eq 0 ]] || { echo "Run ./scripts/solve.sh"; exit 1; }
echo "Text processing lab complete."