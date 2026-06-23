#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LAB_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
DELIV="$LAB_DIR/deliverables"
TPL="$DELIV/templates/fastapi-microservice"
SKEL="$TPL/skeleton"

PASS=0; FAIL=0
pass() { echo "✓ $1"; PASS=$((PASS+1)); }
fail() { echo "✗ $1"; FAIL=$((FAIL+1)); }

echo "=== Backstage Software Templates Lab — Check ==="

[[ -f "$TPL/template.yaml" ]] && pass "template.yaml" || fail "template.yaml"
grep -q 'kind: Template' "$TPL/template.yaml" && pass "Template kind" || fail "Template kind"
grep -q 'fetch:template' "$TPL/template.yaml" && pass "fetch:template action" || fail "fetch:template action"
grep -q 'publish:github' "$TPL/template.yaml" && pass "publish:github action" || fail "publish:github action"
grep -q 'catalog:register' "$TPL/template.yaml" && pass "catalog:register action" || fail "catalog:register action"
grep -q 'serviceName' "$TPL/template.yaml" && pass "serviceName parameter" || fail "serviceName parameter"
grep -q 'owner' "$TPL/template.yaml" && pass "owner parameter" || fail "owner parameter"

[[ -f "$SKEL/src/main.py" ]] && pass "FastAPI skeleton" || fail "FastAPI skeleton"
[[ -f "$SKEL/requirements.txt" ]] && pass "requirements.txt" || fail "requirements.txt"
[[ -f "$SKEL/catalog-info.yaml" ]] && pass "catalog-info.yaml" || fail "catalog-info.yaml"
[[ -f "$SKEL/.github/workflows/ci.yml" ]] && pass "CI workflow" || fail "CI workflow"
grep -q 'FastAPI' "$SKEL/src/main.py" && pass "FastAPI app" || fail "FastAPI app"

[[ -f "$DELIV/app-config.auth-rbac.yaml" ]] && pass "Auth/RBAC config" || fail "Auth/RBAC config"
grep -q 'github' "$DELIV/app-config.auth-rbac.yaml" && pass "GitHub OAuth" || fail "GitHub OAuth"
grep -q 'permission' "$DELIV/app-config.auth-rbac.yaml" && pass "RBAC permissions" || fail "RBAC permissions"
grep -qiE 'kubernetes|prometheus|grafana' "$DELIV/SOFTWARE_TEMPLATES_GUIDE.md" && pass "Integrations guide" || fail "Integrations guide"

echo "Results: $PASS passed, $FAIL failed"
[[ "$FAIL" -eq 0 ]] || { echo "Run ./scripts/solve.sh"; exit 1; }