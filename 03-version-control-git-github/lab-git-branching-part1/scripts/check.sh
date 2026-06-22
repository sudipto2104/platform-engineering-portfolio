#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LAB_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
SANDBOX="$(cd "$LAB_DIR/../taskflow-sandbox" && pwd)"

PASS=0; FAIL=0
pass() { echo "✓ $1"; PASS=$((PASS+1)); }
fail() { echo "✗ $1"; FAIL=$((FAIL+1)); }

echo "=== Git Branching Part 1 — Check ==="

git -C "$SANDBOX" branch | grep -q "feature/12" && pass "Feature branch exists" || fail "Feature branch"
[[ -f "$LAB_DIR/reference/BRANCH_NAMING.md" ]] && pass "Naming guide" || fail "Naming guide"
[[ -f "$LAB_DIR/deliverables/BRANCHING_LOG.md" ]] && pass "Branching log" || fail "Branching log"
grep -qiE "stash|feature|merge|rebase" "$LAB_DIR/deliverables/BRANCHING_LOG.md" \
  && pass "Log content" || fail "Log content"

echo "Results: $PASS passed, $FAIL failed"
[[ "$FAIL" -eq 0 ]] || { echo "Run ./scripts/solve.sh"; exit 1; }