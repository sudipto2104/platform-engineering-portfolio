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

echo "=== TaskFlow Development Plan — Check ==="
echo

check_doc "MVP_DEFINITION.md" "$DELIV/MVP_DEFINITION.md" 18 "MVP|scope|success"
check_doc "SPRINT_PLAN.md" "$DELIV/SPRINT_PLAN.md" 25 "sprint|week|deliverable"
check_doc "RISK_REGISTER.md" "$DELIV/RISK_REGISTER.md" 12 "risk|mitigation|impact"

if [[ -f "$DELIV/SPRINT_PLAN.md" ]]; then
  weeks=$(grep -ciE "week [0-9]+|S[0-9]+" "$DELIV/SPRINT_PLAN.md" 2>/dev/null || echo 0)
  if [[ "$weeks" -ge 10 ]]; then pass "Sprint plan covers bootcamp weeks ($weeks refs)"
  else fail "Sprint plan needs more week/sprint coverage"; fi
fi

if [[ -f "$DELIV/RISK_REGISTER.md" ]]; then
  risks=$(grep -ciE "^\| R[0-9]" "$DELIV/RISK_REGISTER.md" 2>/dev/null || echo 0)
  if [[ "$risks" -ge 5 ]]; then pass "$risks risks documented (5+ required)"
  else fail "$risks risks (need 5+)"; fi
fi

echo
echo "Results: $PASS passed, $FAIL failed"
[[ "$FAIL" -eq 0 ]] || { echo "Run ./scripts/solve.sh"; exit 1; }
echo "Development plan project complete."