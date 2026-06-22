#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LAB_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
SANDBOX="$(cd "$LAB_DIR/../taskflow-sandbox" && pwd)"
WF="$SANDBOX/.github/workflows/quality.yml"

PASS=0; FAIL=0
pass() { echo "✓ $1"; PASS=$((PASS+1)); }
fail() { echo "✗ $1"; FAIL=$((FAIL+1)); }

echo "=== CI/CD Code Quality Part 2 — Check ==="

[[ -f "$LAB_DIR/deliverables/BRANCH_PROTECTION.md" ]] && pass "Branch protection doc" || fail "Branch protection doc"
grep -qiE "require|check|audit|block" "$LAB_DIR/deliverables/BRANCH_PROTECTION.md" \
  && pass "Protection content" || fail "Protection content"

[[ -f "$WF" ]] && pass "Workflow present" || fail "Workflow"
grep -q 'strict' "$WF" && pass "Strict pip-audit" || fail "Strict pip-audit"
! grep -q '|| true' "$WF" && pass "No permissive audit bypass" || fail "Audit bypass still present"
grep -q 'npm audit' "$WF" && pass "npm audit enforced" || fail "npm audit"

echo "Results: $PASS passed, $FAIL failed"
[[ "$FAIL" -eq 0 ]] || { echo "Run ./scripts/solve.sh"; exit 1; }