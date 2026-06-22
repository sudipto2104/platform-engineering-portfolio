#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LAB_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"

PASS=0; FAIL=0
pass() { echo "✓ $1"; PASS=$((PASS+1)); }
fail() { echo "✗ $1"; FAIL=$((FAIL+1)); }

echo "=== System Monitoring Lab — Check ==="

[[ -x "$LAB_DIR/automation/taskflow-monitor.sh" ]] && pass "Monitor script" || fail "Monitor script"
grep -q 'set -euo pipefail' "$LAB_DIR/automation/taskflow-monitor.sh" 2>/dev/null \
  && pass "Monitor uses strict mode" || fail "Strict mode"
grep -qiE 'df|free|ERROR|alert' "$LAB_DIR/automation/taskflow-monitor.sh" \
  && pass "Monitor checks resources/logs" || fail "Monitor checks"

[[ -f "$LAB_DIR/deliverables/MONITORING_REPORT.md" ]] && pass "Monitoring report" || fail "Report"
grep -qiE 'journalctl|top|df|prometheus' "$LAB_DIR/deliverables/MONITORING_REPORT.md" \
  && pass "Report covers tooling" || fail "Report content"

echo "Results: $PASS passed, $FAIL failed"
[[ "$FAIL" -eq 0 ]] || { echo "Run ./scripts/solve.sh"; exit 1; }
echo "System monitoring lab complete."