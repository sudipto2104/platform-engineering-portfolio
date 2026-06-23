#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LAB_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
DELIV="$LAB_DIR/deliverables"

PASS=0; FAIL=0
pass() { echo "✓ $1"; PASS=$((PASS+1)); }
fail() { echo "✗ $1"; FAIL=$((FAIL+1)); }

echo "=== Kustomize ArgoCD Multi-Env Lab — Check ==="

[[ -f "$DELIV/kustomize/base/kustomization.yaml" ]] && pass "base kustomization" || fail "base kustomization"
for env in dev staging production; do
  [[ -f "$DELIV/kustomize/overlays/$env/kustomization.yaml" ]] && pass "overlay $env" || fail "overlay $env"
done

grep -q 'replicas' "$DELIV/kustomize/overlays/production/kustomization.yaml" && pass "Production patches" || fail "Production patches"
grep -q 'namespace' "$DELIV/kustomize/overlays/dev/kustomization.yaml" && pass "Dev namespace" || fail "Dev namespace"

for env in dev staging production; do
  [[ -f "$DELIV/argocd/applications/taskflow-$env.yaml" ]] && pass "Application $env" || fail "Application $env"
  grep -q 'kustomize' "$DELIV/argocd/applications/taskflow-$env.yaml" && pass "Kustomize source $env" || fail "Kustomize source $env"
done

grep -qiE 'kustomize|overlay' "$DELIV/KUSTOMIZE_ARGOCD_GUIDE.md" && pass "Kustomize guide" || fail "Kustomize guide"
grep -qiE 'dev|staging|production' "$DELIV/KUSTOMIZE_ARGOCD_GUIDE.md" && pass "Multi-env guide" || fail "Multi-env guide"

echo "Results: $PASS passed, $FAIL failed"
[[ "$FAIL" -eq 0 ]] || { echo "Run ./scripts/solve.sh"; exit 1; }