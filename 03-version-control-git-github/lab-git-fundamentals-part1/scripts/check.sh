#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LAB_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
SANDBOX="$(cd "$LAB_DIR/../taskflow-sandbox" && pwd)"

PASS=0; FAIL=0
pass() { echo "✓ $1"; PASS=$((PASS+1)); }
fail() { echo "✗ $1"; FAIL=$((FAIL+1)); }

echo "=== Git Fundamentals Part 1 — Check ==="

[[ -d "$SANDBOX/.git" ]] && pass "Sandbox git repo" || fail "Sandbox git repo"
commits=$(git -C "$SANDBOX" rev-list --count HEAD 2>/dev/null || echo 0)
[[ "$commits" -ge 2 ]] && pass "$commits commits (2+)" || fail "commits ($commits)"

[[ -f "$LAB_DIR/deliverables/GIT_SETUP_LOG.md" ]] && pass "GIT_SETUP_LOG.md" || fail "GIT_SETUP_LOG"
grep -qiE "commit|config|staging" "$LAB_DIR/deliverables/GIT_SETUP_LOG.md" \
  && pass "Setup log content" || fail "Setup log content"

if git -C "$SANDBOX" log --oneline | grep "feat:" | head -1 | grep -q .; then
  pass "Conventional commit present"
else
  fail "Conventional commit"
fi

echo "Results: $PASS passed, $FAIL failed"
[[ "$FAIL" -eq 0 ]] || { echo "Run ./scripts/solve.sh"; exit 1; }