#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LAB_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"

PASS=0; FAIL=0
pass() { echo "✓ $1"; PASS=$((PASS+1)); }
fail() { echo "✗ $1"; FAIL=$((FAIL+1)); }

echo "=== Packages & Services Lab — Check ==="

[[ -f "$LAB_DIR/docker-compose.yml" ]] && pass "docker-compose.yml" || fail "docker-compose.yml"
grep -q nginx "$LAB_DIR/docker-compose.yml" && pass "nginx service defined" || fail "nginx"
grep -q postgres "$LAB_DIR/docker-compose.yml" && pass "postgresql service defined" || fail "postgresql"
grep -q redis "$LAB_DIR/docker-compose.yml" && pass "redis service defined" || fail "redis"

[[ -f "$LAB_DIR/reference/systemd/taskflow.service" ]] && pass "systemd unit" || fail "systemd unit"
[[ -f "$LAB_DIR/reference/APT_SETUP.md" ]] && pass "APT guide" || fail "APT guide"

[[ -f "$LAB_DIR/deliverables/STACK_STATUS.md" ]] && pass "Stack status doc" || fail "Stack status"
grep -qiE "nginx|postgres|redis|systemd" "$LAB_DIR/deliverables/STACK_STATUS.md" \
  && pass "Stack doc complete" || fail "Stack doc content"

echo "Results: $PASS passed, $FAIL failed"
[[ "$FAIL" -eq 0 ]] || { echo "Run ./scripts/solve.sh"; exit 1; }
echo "Packages & services lab complete."