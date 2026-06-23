#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LAB_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
DELIV="$LAB_DIR/deliverables"
PKG="$DELIV/taskflow_platform_api"

PASS=0; FAIL=0
pass() { echo "✓ $1"; PASS=$((PASS+1)); }
fail() { echo "✗ $1"; FAIL=$((FAIL+1)); }

echo "=== FastAPI Platform API Lab — Check ==="

[[ -f "$DELIV/requirements.txt" ]] && pass "requirements.txt" || fail "requirements.txt"
grep -q 'fastapi' "$DELIV/requirements.txt" && pass "fastapi dependency" || fail "fastapi dependency"
grep -q 'sqlalchemy' "$DELIV/requirements.txt" && pass "sqlalchemy dependency" || fail "sqlalchemy dependency"
grep -q 'pydantic' "$DELIV/requirements.txt" && pass "pydantic dependency" || fail "pydantic dependency"

for f in main database models schemas; do
  [[ -f "$PKG/${f}.py" ]] && pass "${f}.py" || fail "${f}.py"
done
[[ -f "$PKG/routers/resources.py" ]] && pass "resources router" || fail "resources router"
[[ -f "$PKG/routers/health.py" ]] && pass "health router" || fail "health router"

grep -q 'FastAPI' "$PKG/main.py" && pass "FastAPI app" || fail "FastAPI app"
grep -q 'APIRouter\|include_router' "$PKG/main.py" && pass "Router registration" || fail "Router registration"
grep -q 'declarative_base\|DeclarativeBase' "$PKG/models.py" && pass "SQLAlchemy models" || fail "SQLAlchemy models"
grep -q 'BaseModel' "$PKG/schemas.py" && pass "Pydantic schemas" || fail "Pydantic schemas"
grep -q '@router.get\|@router.post\|@router.put\|@router.delete' "$PKG/routers/resources.py" && pass "CRUD endpoints" || fail "CRUD endpoints"
grep -q 'response_model' "$PKG/routers/resources.py" && pass "Response models" || fail "Response models"
grep -qiE 'openapi|swagger|/docs' "$DELIV/FASTAPI_PLATFORM_API_GUIDE.md" && pass "OpenAPI guide" || fail "OpenAPI guide"
grep -qiE 'restful|crud|platform' "$DELIV/FASTAPI_PLATFORM_API_GUIDE.md" && pass "RESTful guide" || fail "RESTful guide"

echo "Results: $PASS passed, $FAIL failed"
[[ "$FAIL" -eq 0 ]] || { echo "Run ./scripts/solve.sh"; exit 1; }