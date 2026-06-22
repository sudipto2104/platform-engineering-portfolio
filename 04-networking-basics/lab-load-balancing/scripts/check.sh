#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LAB_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"

PASS=0; FAIL=0
pass() { echo "✓ $1"; PASS=$((PASS+1)); }
fail() { echo "✗ $1"; FAIL=$((FAIL+1)); }

echo "=== Load Balancing Lab — Check ==="

[[ -f "$LAB_DIR/config/nginx-lb.conf" ]] && pass "LB nginx config" || fail "LB config"
grep -q upstream "$LAB_DIR/config/nginx-lb.conf" && pass "Upstream defined" || fail "Upstream"
grep -qiE "least_conn|ip_hash|weight|max_fails" "$LAB_DIR/config/nginx-lb.conf" \
  && pass "LB algorithms/health" || fail "LB features"

grep -q taskflow-1 "$LAB_DIR/docker-compose.yml" && pass "3 backends" || fail "Backends"
grep -q taskflow-3 "$LAB_DIR/docker-compose.yml" && pass "Backend pool complete" || fail "Backend pool"

[[ -f "$LAB_DIR/deliverables/LOAD_BALANCER_GUIDE.md" ]] && pass "LB guide" || fail "LB guide"
grep -qiE "round.robin|least|sticky|health|zero.downtime" "$LAB_DIR/deliverables/LOAD_BALANCER_GUIDE.md" \
  && pass "Guide topics" || fail "Guide topics"

echo "Results: $PASS passed, $FAIL failed"
[[ "$FAIL" -eq 0 ]] || { echo "Run ./scripts/solve.sh"; exit 1; }