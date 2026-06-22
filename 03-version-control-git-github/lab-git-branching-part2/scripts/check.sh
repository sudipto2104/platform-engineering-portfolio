#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LAB_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
SANDBOX="$(cd "$LAB_DIR/../taskflow-sandbox" && pwd)"

PASS=0; FAIL=0
pass() { echo "✓ $1"; PASS=$((PASS+1)); }
fail() { echo "✗ $1"; FAIL=$((FAIL+1)); }

echo "=== Git Branching Part 2 — Check ==="

[[ -f "$LAB_DIR/deliverables/CONFLICT_RESOLUTION.md" ]] && pass "Conflict doc" || fail "Conflict doc"
grep -qiE "conflict|rebase|cherry|stash" "$LAB_DIR/deliverables/CONFLICT_RESOLUTION.md" \
  && pass "Doc topics" || fail "Doc topics"

if git -C "$SANDBOX" log --oneline | grep -iE "resolve|merge|cherry" | head -1 | grep -q .; then
  pass "Merge resolution commit"
else
  fail "Merge commits"
fi

! grep -q '<<<<<<<' "$SANDBOX/app.py" 2>/dev/null && pass "No conflict markers in app.py" || fail "Conflict markers remain"

echo "Results: $PASS passed, $FAIL failed"
[[ "$FAIL" -eq 0 ]] || { echo "Run ./scripts/solve.sh"; exit 1; }