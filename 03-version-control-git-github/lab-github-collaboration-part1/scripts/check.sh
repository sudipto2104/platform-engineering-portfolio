#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LAB_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
SANDBOX="$(cd "$LAB_DIR/../taskflow-sandbox" && pwd)"

PASS=0; FAIL=0
pass() { echo "✓ $1"; PASS=$((PASS+1)); }
fail() { echo "✗ $1"; FAIL=$((FAIL+1)); }

echo "=== GitHub Collaboration Part 1 — Check ==="

[[ -f "$SANDBOX/.github/pull_request_template.md" ]] && pass "PR template in sandbox" || fail "PR template"
[[ -f "$SANDBOX/.github/ISSUE_TEMPLATE/task.md" ]] && pass "Issue template" || fail "Issue template"

[[ -f "$LAB_DIR/deliverables/ISSUE_AND_PR_WORKFLOW.md" ]] && pass "Workflow doc" || fail "Workflow doc"
[[ -f "$LAB_DIR/deliverables/SAMPLE_ISSUE.md" ]] && pass "Sample issue" || fail "Sample issue"
grep -qiE "PR|issue|Closes|review" "$LAB_DIR/deliverables/ISSUE_AND_PR_WORKFLOW.md" \
  && pass "Workflow content" || fail "Workflow content"

echo "Results: $PASS passed, $FAIL failed"
[[ "$FAIL" -eq 0 ]] || { echo "Run ./scripts/solve.sh"; exit 1; }