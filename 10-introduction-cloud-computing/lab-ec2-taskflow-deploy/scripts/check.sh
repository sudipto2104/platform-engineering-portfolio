#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LAB_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
DELIV="$LAB_DIR/deliverables"

PASS=0; FAIL=0
pass() { echo "✓ $1"; PASS=$((PASS+1)); }
fail() { echo "✗ $1"; FAIL=$((FAIL+1)); }

echo "=== EC2 TaskFlow Deploy Lab — Check ==="

[[ -f "$DELIV/user-data.sh" ]] && pass "user-data.sh" || fail "user-data"
[[ -f "$DELIV/docker-compose.ec2.yml" ]] && pass "docker-compose" || fail "compose"
[[ -f "$DELIV/nginx-ec2.conf" ]] && pass "nginx config" || fail "nginx"
[[ -f "$DELIV/security-groups.json" ]] && pass "security groups" || fail "SG"

grep -q 'docker' "$DELIV/user-data.sh" && pass "Docker install" || fail "Docker"
grep -q 'proxy_pass' "$DELIV/nginx-ec2.conf" && pass "Reverse proxy" || fail "Proxy"
grep -q 'taskflow-api' "$DELIV/docker-compose.ec2.yml" && pass "TaskFlow services" || fail "Services"
grep -qiE 'EC2|security.group' "$DELIV/EC2_DEPLOY_GUIDE.md" && pass "Deploy guide" || fail "Guide"

echo "Results: $PASS passed, $FAIL failed"
[[ "$FAIL" -eq 0 ]] || { echo "Run ./scripts/solve.sh"; exit 1; }