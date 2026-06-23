#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LAB_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
DELIV="$LAB_DIR/deliverables"
PKG="$DELIV/taskflow_platform_api"
AUTH="$PKG/auth"

PASS=0; FAIL=0
pass() { echo "✓ $1"; PASS=$((PASS+1)); }
fail() { echo "✗ $1"; FAIL=$((FAIL+1)); }

echo "=== FastAPI JWT RBAC Lab — Check ==="

[[ -f "$DELIV/requirements.txt" ]] && pass "requirements.txt" || fail "requirements.txt"
grep -q 'python-jose\|pyjwt\|jose' "$DELIV/requirements.txt" && pass "JWT dependency" || fail "JWT dependency"
grep -q 'passlib\|bcrypt' "$DELIV/requirements.txt" && pass "Password hashing" || fail "Password hashing"

for f in jwt_handler dependencies rbac; do
  [[ -f "$AUTH/${f}.py" ]] && pass "${f}.py" || fail "${f}.py"
done
[[ -f "$PKG/routers/auth.py" ]] && pass "auth router" || fail "auth router"

grep -q 'create_access_token\|jwt\|JWT' "$AUTH/jwt_handler.py" && pass "JWT tokens" || fail "JWT tokens"
grep -q 'OAuth2PasswordBearer\|get_current_user' "$AUTH/dependencies.py" && pass "Auth dependencies" || fail "Auth dependencies"
grep -q 'admin\|operator\|viewer\|Role' "$AUTH/rbac.py" && pass "RBAC roles" || fail "RBAC roles"
grep -q 'require_role\|check_permission\|Permission' "$AUTH/rbac.py" && pass "Permission checks" || fail "Permission checks"
grep -q '/login\|token' "$PKG/routers/auth.py" && pass "Login endpoint" || fail "Login endpoint"
grep -q 'Depends' "$PKG/routers/resources.py" && pass "Protected routes" || fail "Protected routes"
grep -qiE 'jwt|rbac|role' "$DELIV/JWT_RBAC_GUIDE.md" && pass "JWT guide" || fail "JWT guide"
grep -qiE 'authentication|authorization' "$DELIV/JWT_RBAC_GUIDE.md" && pass "Auth guide" || fail "Auth guide"

echo "Results: $PASS passed, $FAIL failed"
[[ "$FAIL" -eq 0 ]] || { echo "Run ./scripts/solve.sh"; exit 1; }