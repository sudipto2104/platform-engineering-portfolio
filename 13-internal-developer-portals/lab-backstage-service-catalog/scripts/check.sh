#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LAB_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
DELIV="$LAB_DIR/deliverables"
CAT="$DELIV/catalog"

PASS=0; FAIL=0
pass() { echo "✓ $1"; PASS=$((PASS+1)); }
fail() { echo "✗ $1"; FAIL=$((FAIL+1)); }

echo "=== Backstage Service Catalog Lab — Check ==="

[[ -f "$DELIV/workspace/app-config.yaml" ]] && pass "app-config.yaml" || fail "app-config.yaml"
grep -q 'catalog:' "$DELIV/workspace/app-config.yaml" && pass "catalog config" || fail "catalog config"
grep -q 'github' "$DELIV/workspace/app-config.yaml" && pass "GitHub integration" || fail "GitHub integration"

for entity in domain system taskflow-frontend taskflow-backend taskflow-postgres taskflow-redis taskflow-api; do
  [[ -f "$CAT/${entity}.yaml" ]] && pass "${entity}.yaml" || fail "${entity}.yaml"
done

grep -q 'kind: Domain' "$CAT/domain.yaml" && pass "Domain entity" || fail "Domain entity"
grep -q 'kind: System' "$CAT/system.yaml" && pass "System entity" || fail "System entity"
grep -q 'kind: Component' "$CAT/taskflow-frontend.yaml" && pass "Frontend component" || fail "Frontend component"
grep -q 'kind: API' "$CAT/taskflow-api.yaml" && pass "API entity" || fail "API entity"
grep -q 'kind: Resource' "$CAT/taskflow-postgres.yaml" && pass "Postgres resource" || fail "Postgres resource"
grep -q 'kind: Resource' "$CAT/taskflow-redis.yaml" && pass "Redis resource" || fail "Redis resource"

grep -q 'dependsOn' "$CAT/taskflow-frontend.yaml" && pass "Frontend dependsOn" || fail "Frontend dependsOn"
grep -q 'providesApis' "$CAT/taskflow-backend.yaml" && pass "Backend providesApis" || fail "Backend providesApis"
grep -q 'sudipto2104' "$CAT/taskflow-backend.yaml" && pass "GitHub repo link" || fail "GitHub repo link"

grep -qiE 'useState|useEffect' "$DELIV/REACT_VS_VUE.md" && pass "React hooks comparison" || fail "React hooks comparison"
grep -qiE 'composition api|ref\(|onMounted' "$DELIV/REACT_VS_VUE.md" && pass "Vue comparison" || fail "Vue comparison"
grep -qiE 'catalog|entity|backstage' "$DELIV/BACKSTAGE_CATALOG_GUIDE.md" && pass "Catalog guide" || fail "Catalog guide"

echo "Results: $PASS passed, $FAIL failed"
[[ "$FAIL" -eq 0 ]] || { echo "Run ./scripts/solve.sh"; exit 1; }