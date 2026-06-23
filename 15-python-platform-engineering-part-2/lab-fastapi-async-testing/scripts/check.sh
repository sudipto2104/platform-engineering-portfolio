#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LAB_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
DELIV="$LAB_DIR/deliverables"
PKG="$DELIV/taskflow_platform_api"

PASS=0; FAIL=0
pass() { echo "✓ $1"; PASS=$((PASS+1)); }
fail() { echo "✗ $1"; FAIL=$((FAIL+1)); }

echo "=== FastAPI Async & Testing Lab — Check ==="

[[ -f "$DELIV/requirements.txt" ]] && pass "requirements.txt" || fail "requirements.txt"
grep -q 'pytest' "$DELIV/requirements.txt" && pass "pytest dependency" || fail "pytest dependency"
grep -q 'httpx' "$DELIV/requirements.txt" && pass "httpx dependency" || fail "httpx dependency"
[[ -f "$DELIV/pytest.ini" ]] && pass "pytest.ini" || fail "pytest.ini"

[[ -f "$PKG/tasks/background.py" ]] && pass "background tasks" || fail "background tasks"
[[ -f "$PKG/routers/deployments.py" ]] && pass "deployments router" || fail "deployments router"
[[ -f "$PKG/tests/test_api.py" ]] && pass "test_api.py" || fail "test_api.py"
[[ -f "$PKG/tests/conftest.py" ]] && pass "conftest.py" || fail "conftest.py"

grep -q 'BackgroundTasks' "$PKG/routers/deployments.py" && pass "BackgroundTasks usage" || fail "BackgroundTasks usage"
grep -q 'async def' "$PKG/routers/deployments.py" && pass "Async endpoints" || fail "Async endpoints"
grep -q 'async def\|asyncio' "$PKG/tasks/background.py" && pass "Async background work" || fail "Async background work"
grep -q 'TestClient' "$PKG/tests/test_api.py" && pass "TestClient tests" || fail "TestClient tests"
grep -q 'def test_' "$PKG/tests/test_api.py" && pass "Test functions" || fail "Test functions"
grep -q 'fixture\|TestClient' "$PKG/tests/conftest.py" && pass "Pytest fixtures" || fail "Pytest fixtures"
grep -qiE 'background|async' "$DELIV/ASYNC_TESTING_GUIDE.md" && pass "Async guide" || fail "Async guide"
grep -qiE 'pytest|test' "$DELIV/ASYNC_TESTING_GUIDE.md" && pass "Testing guide" || fail "Testing guide"

echo "Results: $PASS passed, $FAIL failed"
[[ "$FAIL" -eq 0 ]] || { echo "Run ./scripts/solve.sh"; exit 1; }