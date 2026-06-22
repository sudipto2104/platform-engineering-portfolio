#!/usr/bin/env bash
# Verify DevOps analysis deliverables are complete.
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LAB_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
DELIV="$LAB_DIR/deliverables"

PASS=0
FAIL=0
MIN_LINES=15

pass() { echo "✓ $1"; PASS=$((PASS + 1)); }
fail() { echo "✗ $1"; FAIL=$((FAIL + 1)); }

check_file() {
  local name="$1"
  local path="$2"
  if [[ ! -f "$path" ]]; then
    fail "$name exists"
    return
  fi
  local lines
  lines=$(grep -cve '^\s*$' "$path" 2>/dev/null || echo 0)
  if [[ "$lines" -lt "$MIN_LINES" ]]; then
    fail "$name has substantive content ($lines non-empty lines, need $MIN_LINES+)"
  else
    pass "$name complete ($lines lines)"
  fi
}

echo "=== DevOps Analysis Lab — Check ==="
echo

[[ -f "$LAB_DIR/scenario/MERIDIAN_RETAIL.md" ]] && pass "Scenario document present" || fail "Scenario document present"

check_file "ANTI_PATTERNS.md" "$DELIV/ANTI_PATTERNS.md"
check_file "DORA_ASSESSMENT.md" "$DELIV/DORA_ASSESSMENT.md"
check_file "IMPROVEMENT_PLAN.md" "$DELIV/IMPROVEMENT_PLAN.md"

if [[ -f "$DELIV/ANTI_PATTERNS.md" ]] && grep -qi "anti-pattern\|evidence\|impact" "$DELIV/ANTI_PATTERNS.md"; then
  pass "ANTI_PATTERNS.md uses expected structure"
else
  fail "ANTI_PATTERNS.md uses expected structure"
fi

if [[ -f "$DELIV/DORA_ASSESSMENT.md" ]] && grep -qi "deployment frequency\|lead time\|change failure\|time to restore" "$DELIV/DORA_ASSESSMENT.md"; then
  pass "DORA_ASSESSMENT.md covers all four metrics"
else
  fail "DORA_ASSESSMENT.md covers all four metrics"
fi

if [[ -f "$DELIV/IMPROVEMENT_PLAN.md" ]] && grep -qi "taskflow\|priority\|business" "$DELIV/IMPROVEMENT_PLAN.md"; then
  pass "IMPROVEMENT_PLAN.md includes business and TaskFlow context"
else
  fail "IMPROVEMENT_PLAN.md includes business and TaskFlow context"
fi

echo
echo "Results: $PASS passed, $FAIL failed"
if [[ "$FAIL" -gt 0 ]]; then
  echo "Complete deliverables/ using templates/, or run ./scripts/solve.sh for reference content."
  exit 1
fi
echo "DevOps analysis lab complete."