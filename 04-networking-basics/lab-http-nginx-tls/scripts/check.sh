#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LAB_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"

PASS=0; FAIL=0
pass() { echo "✓ $1"; PASS=$((PASS+1)); }
fail() { echo "✗ $1"; FAIL=$((FAIL+1)); }

echo "=== HTTP / Nginx / TLS Lab — Check ==="

[[ -f "$LAB_DIR/config/nginx-http.conf" ]] && pass "nginx HTTP config" || fail "nginx HTTP"
[[ -f "$LAB_DIR/config/nginx-https.conf" ]] && pass "nginx HTTPS config" || fail "nginx HTTPS"
grep -q ssl_certificate "$LAB_DIR/config/nginx-https.conf" && pass "TLS configured" || fail "TLS"
[[ -f "$LAB_DIR/certs/taskflow.crt" && -f "$LAB_DIR/certs/taskflow.key" ]] && pass "TLS certs" || fail "TLS certs"

[[ -f "$LAB_DIR/deliverables/HTTP_CURL_GUIDE.md" ]] && pass "curl guide" || fail "curl guide"
grep -qiE "curl|status|header|HTTPS|502" "$LAB_DIR/deliverables/HTTP_CURL_GUIDE.md" \
  && pass "HTTP topics" || fail "HTTP topics"

echo "Results: $PASS passed, $FAIL failed"
[[ "$FAIL" -eq 0 ]] || { echo "Run ./scripts/solve.sh"; exit 1; }