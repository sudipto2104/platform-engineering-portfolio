#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LAB_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
DELIV="$LAB_DIR/deliverables"
AUTO="$LAB_DIR/automation"

PASS=0
FAIL=0

pass() { echo "✓ $1"; PASS=$((PASS + 1)); }
fail() { echo "✗ $1"; FAIL=$((FAIL + 1)); }

check_doc() {
  local name="$1" path="$2" min="$3" pattern="$4"
  [[ -f "$path" ]] || { fail "$name exists"; return; }
  local lines
  lines=$(grep -cve '^\s*$' "$path" 2>/dev/null || echo 0)
  [[ "$lines" -ge "$min" ]] || { fail "$name ($lines lines, need $min+)"; return; }
  [[ -z "$pattern" || "$(grep -qiE "$pattern" "$path" && echo y)" == "y" ]] \
    || { fail "$name missing sections"; return; }
  pass "$name"
}

check_script() {
  local name="$1" path="$2"
  [[ -f "$path" ]] || { fail "$name exists"; return; }
  [[ -x "$path" ]] || { fail "$name executable"; return; }
  grep -q 'set -euo pipefail' "$path" || { fail "$name uses errexit"; return; }
  grep -qi 'log' "$path" || { fail "$name has logging"; return; }
  pass "$name"
}

echo "=== Platform Automation Lab — Check ==="
echo

[[ -f "$LAB_DIR/scenario/MANUAL_WORKFLOWS.md" ]] && pass "Scenario present" || fail "Scenario present"

check_doc "WORKFLOW_ANALYSIS.md" "$DELIV/WORKFLOW_ANALYSIS.md" 15 "workflow|automate|ROI"
check_doc "AUTOMATION_DECISIONS.md" "$DELIV/AUTOMATION_DECISIONS.md" 12 "decision|idempot|automate"

check_script "taskflow-setup.sh" "$AUTO/taskflow-setup.sh"
check_script "taskflow-health.sh" "$AUTO/taskflow-health.sh"
check_script "taskflow-smoke.sh" "$AUTO/taskflow-smoke.sh"

echo
echo "Results: $PASS passed, $FAIL failed"
[[ "$FAIL" -eq 0 ]] || { echo "Run ./scripts/solve.sh"; exit 1; }
echo "Platform automation lab complete."