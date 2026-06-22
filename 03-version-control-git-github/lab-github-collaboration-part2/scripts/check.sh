#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LAB_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"

PASS=0; FAIL=0
pass() { echo "✓ $1"; PASS=$((PASS+1)); }
fail() { echo "✗ $1"; FAIL=$((FAIL+1)); }

echo "=== GitHub Collaboration Part 2 — Check ==="

[[ -f "$LAB_DIR/deliverables/PR_REVIEW_GUIDE.md" ]] && pass "Review guide" || fail "Review guide"
[[ -f "$LAB_DIR/deliverables/SAMPLE_PR_REVIEW.md" ]] && pass "Sample review" || fail "Sample review"
grep -qiE "squash|rebase|merge|approve|branch" "$LAB_DIR/deliverables/PR_REVIEW_GUIDE.md" \
  && pass "Merge strategies documented" || fail "Merge strategies"

echo "Results: $PASS passed, $FAIL failed"
[[ "$FAIL" -eq 0 ]] || { echo "Run ./scripts/solve.sh"; exit 1; }