#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LAB_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
DELIV="$LAB_DIR/deliverables"

PASS=0; FAIL=0
pass() { echo "✓ $1"; PASS=$((PASS+1)); }
fail() { echo "✗ $1"; FAIL=$((FAIL+1)); }

echo "=== Functions & Libraries Lab — Check ==="

[[ -x "$DELIV/deploy_module.sh" ]] && pass "deploy_module.sh" || fail "deploy_module.sh"
[[ -f "$DELIV/lib/logging.sh" && -f "$DELIV/lib/common.sh" ]] && pass "Function library" || fail "Library"
grep -q 'source.*logging' "$DELIV/deploy_module.sh" && pass "Sourcing library" || fail "Sourcing"
grep -q 'deploy_api\|deploy_frontend' "$DELIV/deploy_module.sh" && pass "Functions defined" || fail "Functions"
grep -q 'local ' "$DELIV/deploy_module.sh" && pass "Local scope" || fail "Local scope"
grep -q 'retry\|require_cmd' "$DELIV/lib/common.sh" && pass "Error helpers" || fail "Error helpers"

[[ -f "$DELIV/deploy_report.txt" ]] && pass "Deploy report" || fail "Deploy report"
grep -q 'Deploy complete' "$DELIV/deploy_report.txt" && pass "Deploy ran" || fail "Deploy ran"

echo "Results: $PASS passed, $FAIL failed"
[[ "$FAIL" -eq 0 ]] || { echo "Run ./scripts/solve.sh"; exit 1; }