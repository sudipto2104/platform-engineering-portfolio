#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LAB_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
DELIV="$LAB_DIR/deliverables"

PASS=0; FAIL=0
pass() { echo "✓ $1"; PASS=$((PASS+1)); }
fail() { echo "✗ $1"; FAIL=$((FAIL+1)); }

echo "=== K8s Config & State Lab — Check ==="

[[ -f "$DELIV/configmap.yaml" ]] && pass "ConfigMap" || fail "ConfigMap"
[[ -f "$DELIV/secret.yaml" ]] && pass "Secret" || fail "Secret"
grep -q 'StatefulSet' "$DELIV/postgres-statefulset.yaml" && pass "Postgres StatefulSet" || fail "StatefulSet"
grep -q 'volumeClaimTemplates' "$DELIV/postgres-statefulset.yaml" && pass "PVC template" || fail "PVC"
grep -q 'kind: Deployment' "$DELIV/redis-deployment.yaml" && pass "Redis Deployment" || fail "Redis"
grep -q 'envFrom\|secretKeyRef' "$DELIV/backend-deployment.yaml" && pass "Env injection" || fail "Env injection"
grep -qiE 'persistence|12-factor|ConfigMap' "$DELIV/CONFIG_STATE_GUIDE.md" && pass "Config guide" || fail "Guide"

echo "Results: $PASS passed, $FAIL failed"
[[ "$FAIL" -eq 0 ]] || { echo "Run ./scripts/solve.sh"; exit 1; }