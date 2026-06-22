#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LAB_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
DOC="$LAB_DIR/deliverables/SERVER_BASELINE.md"

PASS=0; FAIL=0
pass() { echo "✓ $1"; PASS=$((PASS+1)); }
fail() { echo "✗ $1"; FAIL=$((FAIL+1)); }

echo "=== Server Configuration Lab — Check ==="

[[ -f "$DOC" ]] && pass "SERVER_BASELINE.md" || fail "SERVER_BASELINE.md"
for kw in hostname SSH UFW sudo; do
  grep -qi "$kw" "$DOC" 2>/dev/null && pass "covers $kw" || fail "covers $kw"
done

[[ -f "$LAB_DIR/reference/ufw/rules.sh" ]] && pass "UFW reference" || fail "UFW reference"
[[ -f "$LAB_DIR/reference/ssh/sshd_config.snippet" ]] && pass "SSH reference" || fail "SSH reference"

checked=$(grep -c '\[x\]' "$DOC" 2>/dev/null || echo 0)
[[ "$checked" -ge 10 ]] && pass "$checked checklist items complete" || fail "checklist items ($checked, need 10+)"

echo "Results: $PASS passed, $FAIL failed"
[[ "$FAIL" -eq 0 ]] || { echo "Run ./scripts/solve.sh"; exit 1; }
echo "Server configuration lab complete."