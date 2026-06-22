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
  if [[ ! -f "$path" ]]; then fail "$name exists"; return; fi
  local lines
  lines=$(grep -cve '^\s*$' "$path" 2>/dev/null || echo 0)
  if [[ "$lines" -lt "$min" ]]; then fail "$name ($lines lines, need $min+)"; return; fi
  if [[ -n "$pattern" ]] && ! grep -qiE "$pattern" "$path"; then fail "$name missing sections"; return; fi
  pass "$name"
}

echo "=== TaskFlow Architecture Project — Check ==="
echo

check_doc "TECHNOLOGY_DECISIONS.md" "$DELIV/TECHNOLOGY_DECISIONS.md" 25 "ADR|decision|alternative"
check_doc "SYSTEM_ARCHITECTURE.md" "$DELIV/SYSTEM_ARCHITECTURE.md" 25 "architecture|mermaid|component"
check_doc "COMPONENT_INTERACTIONS.md" "$DELIV/COMPONENT_INTERACTIONS.md" 20 "interaction|sequence|failure"

if [[ -f "$DELIV/TECHNOLOGY_DECISIONS.md" ]]; then
  adrs=$(grep -ciE "^## ADR-" "$DELIV/TECHNOLOGY_DECISIONS.md" 2>/dev/null || echo 0)
  if [[ "$adrs" -ge 4 ]]; then pass "$adrs technology decisions (4+ required)"
  else fail "$adrs technology decisions (need 4+ ADRs)"; fi
fi

if [[ -f "$DELIV/SYSTEM_ARCHITECTURE.md" ]] && grep -q '```mermaid' "$DELIV/SYSTEM_ARCHITECTURE.md"; then
  pass "System architecture includes mermaid diagrams"
else
  fail "System architecture includes mermaid diagrams"
fi

echo
echo "Results: $PASS passed, $FAIL failed"
[[ "$FAIL" -eq 0 ]] || { echo "Complete deliverables/ or run ./scripts/solve.sh"; exit 1; }
echo "Architecture project complete."