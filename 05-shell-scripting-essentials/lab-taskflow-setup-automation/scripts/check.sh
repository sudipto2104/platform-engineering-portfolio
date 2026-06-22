#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LAB_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
DELIV="$LAB_DIR/deliverables"

PASS=0; FAIL=0
pass() { echo "✓ $1"; PASS=$((PASS+1)); }
fail() { echo "✗ $1"; FAIL=$((FAIL+1)); }

echo "=== TaskFlow Setup Automation Lab — Check ==="

[[ -x "$DELIV/setup_taskflow.sh" ]] && pass "setup_taskflow.sh" || fail "setup_taskflow.sh"
[[ -x "$DELIV/validate_env.sh" ]] && pass "validate_env.sh" || fail "validate_env.sh"
[[ -x "$DELIV/init_services.sh" ]] && pass "init_services.sh" || fail "init_services.sh"
[[ -f "$DELIV/lib/taskflow.sh" ]] && pass "taskflow library" || fail "library"

grep -q 'sandbox\|full' "$DELIV/setup_taskflow.sh" && pass "Multi-mode setup" || fail "Modes"
grep -q 'taskflow-sandbox' "$DELIV/setup_taskflow.sh" && pass "Sandbox integration" || fail "Sandbox path"
grep -q 'health' "$DELIV/setup_taskflow.sh" && pass "Health checks" || fail "Health checks"
grep -qiE 'postgres|redis|react|frontend' "$DELIV/AUTOMATION_RUNBOOK.md" && pass "Full stack docs" || fail "Stack docs"

[[ -f "$DELIV/runtime/SETUP_REPORT.md" ]] && pass "Setup report" || fail "Setup report"
[[ -f "$DELIV/runtime/config/taskflow.env" ]] && pass "Generated config" || fail "Config"

echo "Results: $PASS passed, $FAIL failed"
[[ "$FAIL" -eq 0 ]] || { echo "Run ./scripts/solve.sh"; exit 1; }