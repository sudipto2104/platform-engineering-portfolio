#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
DELIV="$PROJECT_DIR/deliverables"

PASS=0
FAIL=0

pass() { echo "✓ $1"; PASS=$((PASS + 1)); }
fail() { echo "✗ $1"; FAIL=$((FAIL + 1)); }

check_doc() {
  local name="$1" path="$2" min="$3" pattern="$4"
  [[ -f "$path" ]] || { fail "$name exists"; return; }
  local lines
  lines=$(grep -cve '^\s*$' "$path" 2>/dev/null || echo 0)
  [[ "$lines" -ge "$min" ]] || { fail "$name ($lines lines)"; return; }
  grep -qiE "$pattern" "$path" || { fail "$name sections"; return; }
  pass "$name"
}

echo "=== DevOps Transformation Capstone — Check ==="
echo

[[ -f "$PROJECT_DIR/scenario/APEX_LOGISTICS.md" ]] && pass "Scenario" || fail "Scenario"

check_doc "MATURITY_ASSESSMENT.md" "$DELIV/MATURITY_ASSESSMENT.md" 18 "DORA|maturity|capability"
check_doc "TRANSFORMATION_STRATEGY.md" "$DELIV/TRANSFORMATION_STRATEGY.md" 20 "phase|initiative|taskflow"
check_doc "BUSINESS_CASE.md" "$DELIV/BUSINESS_CASE.md" 18 "ROI|benefit|investment|risk"

for script in deploy-readiness-check.sh onboarding-audit.sh toil-ticket-report.sh; do
  path="$DELIV/prototypes/$script"
  if [[ -f "$path" && -x "$path" ]] && grep -q 'set -euo pipefail' "$path"; then
    pass "prototype $script"
  else
    fail "prototype $script"
  fi
done

[[ -f "$DELIV/data/sample_tickets.csv" ]] && pass "sample ticket data" || fail "sample ticket data"

echo
echo "Results: $PASS passed, $FAIL failed"
[[ "$FAIL" -eq 0 ]] || { echo "Run ./scripts/solve.sh"; exit 1; }
echo "Transformation capstone complete."