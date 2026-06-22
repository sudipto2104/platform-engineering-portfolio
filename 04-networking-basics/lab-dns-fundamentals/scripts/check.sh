#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LAB_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"

PASS=0; FAIL=0
pass() { echo "✓ $1"; PASS=$((PASS+1)); }
fail() { echo "✗ $1"; FAIL=$((FAIL+1)); }

echo "=== DNS Fundamentals Lab — Check ==="

[[ -f "$LAB_DIR/workspace/taskflow.zone" ]] && pass "Zone file" || fail "Zone file"
grep -q " IN  A " "$LAB_DIR/workspace/taskflow.zone" && pass "A records" || fail "A records"
grep -q " CNAME " "$LAB_DIR/workspace/taskflow.zone" && pass "CNAME record" || fail "CNAME"
grep -q " MX " "$LAB_DIR/workspace/taskflow.zone" && pass "MX record" || fail "MX"
grep -q " TXT " "$LAB_DIR/workspace/taskflow.zone" && pass "TXT record" || fail "TXT"

[[ -f "$LAB_DIR/deliverables/DNS_RUNBOOK.md" ]] && pass "DNS runbook" || fail "DNS runbook"
grep -qiE "dig|TTL|troubleshoot|kubernetes|svc" "$LAB_DIR/deliverables/DNS_RUNBOOK.md" \
  && pass "Runbook topics" || fail "Runbook topics"

echo "Results: $PASS passed, $FAIL failed"
[[ "$FAIL" -eq 0 ]] || { echo "Run ./scripts/solve.sh"; exit 1; }