#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LAB_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
DELIV="$LAB_DIR/deliverables"

PASS=0
FAIL=0
MIN_LINES=12

pass() { echo "✓ $1"; PASS=$((PASS + 1)); }
fail() { echo "✗ $1"; FAIL=$((FAIL + 1)); }

check_file() {
  local name="$1" path="$2"
  if [[ ! -f "$path" ]]; then fail "$name exists"; return; fi
  local lines
  lines=$(grep -cve '^\s*$' "$path" 2>/dev/null || echo 0)
  if [[ "$lines" -lt "$MIN_LINES" ]]; then
    fail "$name substantive ($lines lines, need $MIN_LINES+)"
  else
    pass "$name complete"
  fi
}

echo "=== IDP Strategy Lab — Check ==="
echo

[[ -f "$LAB_DIR/scenario/NOVASTREAM.md" ]] && pass "Scenario present" || fail "Scenario present"

check_file "DEVELOPER_EXPERIENCE_ASSESSMENT.md" "$DELIV/DEVELOPER_EXPERIENCE_ASSESSMENT.md"
check_file "PLATFORM_CAPABILITIES.md" "$DELIV/PLATFORM_CAPABILITIES.md"
check_file "TEAM_STRUCTURE.md" "$DELIV/TEAM_STRUCTURE.md"
check_file "PLATFORM_ROADMAP.md" "$DELIV/PLATFORM_ROADMAP.md"

[[ -f "$DELIV/DEVELOPER_EXPERIENCE_ASSESSMENT.md" ]] && grep -qiE "pain|golden|metric|developer" "$DELIV/DEVELOPER_EXPERIENCE_ASSESSMENT.md" \
  && pass "DX assessment structure" || fail "DX assessment structure"

[[ -f "$DELIV/PLATFORM_CAPABILITIES.md" ]] && grep -qiE "capability|self-service|non-goal" "$DELIV/PLATFORM_CAPABILITIES.md" \
  && pass "Platform capabilities structure" || fail "Platform capabilities structure"

[[ -f "$DELIV/TEAM_STRUCTURE.md" ]] && grep -qiE "team|role|interaction|squad" "$DELIV/TEAM_STRUCTURE.md" \
  && pass "Team structure content" || fail "Team structure content"

[[ -f "$DELIV/PLATFORM_ROADMAP.md" ]] && grep -qiE "phase|roadmap|business|taskflow" "$DELIV/PLATFORM_ROADMAP.md" \
  && pass "Roadmap aligned to business" || fail "Roadmap aligned to business"

echo
echo "Results: $PASS passed, $FAIL failed"
[[ "$FAIL" -eq 0 ]] || { echo "Complete deliverables/ or run ./scripts/solve.sh"; exit 1; }
echo "IDP strategy lab complete."