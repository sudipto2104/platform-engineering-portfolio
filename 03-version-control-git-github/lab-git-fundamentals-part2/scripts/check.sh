#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LAB_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
SANDBOX="$(cd "$LAB_DIR/../taskflow-sandbox" && pwd)"

PASS=0; FAIL=0
pass() { echo "✓ $1"; PASS=$((PASS+1)); }
fail() { echo "✗ $1"; FAIL=$((FAIL+1)); }

echo "=== Git Fundamentals Part 2 — Check ==="

git -C "$SANDBOX" remote get-url origin &>/dev/null && pass "Remote configured" || fail "Remote"
[[ -d "$LAB_DIR/workspace/taskflow-remote.git" ]] && pass "Bare remote repo" || fail "Bare remote"

[[ -f "$LAB_DIR/deliverables/HISTORY_REPORT.md" ]] && pass "History report" || fail "History report"
grep -qiE "log|blame|bisect|remote" "$LAB_DIR/deliverables/HISTORY_REPORT.md" \
  && pass "Report sections" || fail "Report sections"

echo "Results: $PASS passed, $FAIL failed"
[[ "$FAIL" -eq 0 ]] || { echo "Run ./scripts/solve.sh"; exit 1; }