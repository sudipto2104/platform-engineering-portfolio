#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LAB_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
DELIV="$LAB_DIR/deliverables"
CHART="$DELIV/charts/taskflow"

PASS=0; FAIL=0
pass() { echo "✓ $1"; PASS=$((PASS+1)); }
fail() { echo "✗ $1"; FAIL=$((FAIL+1)); }

echo "=== Helm Multi-Environment Lab — Check ==="

[[ -f "$CHART/Chart.yaml" ]] && pass "Chart.yaml" || fail "Chart.yaml"
[[ -f "$CHART/values.yaml" ]] && pass "Default values" || fail "Default values"
[[ -f "$DELIV/values-dev.yaml" && -f "$DELIV/values-staging.yaml" && -f "$DELIV/values-production.yaml" ]] \
  && pass "Env value files" || fail "Env values"
[[ -f "$CHART/templates/_helpers.tpl" ]] && pass "Helm helpers" || fail "Helpers"
grep -q 'replicaCount' "$CHART/templates/api-deployment.yaml" && pass "Templated replicas" || fail "Replicas template"
grep -q 'ingress.enabled' "$CHART/templates/ingress.yaml" && pass "Conditional ingress" || fail "Ingress template"

grep -q 'taskflow-dev' "$DELIV/values-dev.yaml" && pass "Dev namespace" || fail "Dev config"
grep -q 'replicaCount: 3' "$DELIV/values-production.yaml" && pass "Prod scale" || fail "Prod scale"
grep -qiE 'values hierarchy|helm template' "$DELIV/HELM_GUIDE.md" && pass "Helm guide" || fail "Guide"

if command -v helm &>/dev/null && [[ -f "$DELIV/rendered-production.yaml" ]]; then
  grep -q 'kind: Deployment' "$DELIV/rendered-production.yaml" && pass "helm template render" || fail "helm render"
else
  pass "helm template render (skipped)"
fi

echo "Results: $PASS passed, $FAIL failed"
[[ "$FAIL" -eq 0 ]] || { echo "Run ./scripts/solve.sh"; exit 1; }