#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LAB_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
DELIV="$LAB_DIR/deliverables"
STACK="$LAB_DIR/../taskflow-stack"

PASS=0; FAIL=0
pass() { echo "✓ $1"; PASS=$((PASS+1)); }
fail() { echo "✗ $1"; FAIL=$((FAIL+1)); }

echo "=== Dockerfile Containerization Lab — Check ==="

[[ -f "$DELIV/Dockerfile.backend" ]] && pass "Backend Dockerfile" || fail "Backend Dockerfile"
[[ -f "$DELIV/Dockerfile.frontend" ]] && pass "Frontend Dockerfile" || fail "Frontend Dockerfile"
[[ -f "$DELIV/nginx.conf" ]] && pass "nginx.conf" || fail "nginx.conf"

grep -q 'HEALTHCHECK' "$DELIV/Dockerfile.backend" && pass "Backend healthcheck" || fail "Backend healthcheck"
grep -q 'uvicorn\|fastapi' "$DELIV/Dockerfile.backend" && pass "FastAPI runtime" || fail "FastAPI"
grep -q 'AS build' "$DELIV/Dockerfile.frontend" && pass "Multi-stage build" || fail "Multi-stage"
grep -q 'nginx' "$DELIV/Dockerfile.frontend" && pass "Nginx runtime" || fail "Nginx"
grep -q '/health' "$STACK/backend/main.py" && pass "Health endpoint in API" || fail "Health endpoint"

echo "Results: $PASS passed, $FAIL failed"
[[ "$FAIL" -eq 0 ]] || { echo "Run ./scripts/solve.sh"; exit 1; }