#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LAB_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
DELIV="$LAB_DIR/deliverables"

PASS=0; FAIL=0
pass() { echo "✓ $1"; PASS=$((PASS+1)); }
fail() { echo "✗ $1"; FAIL=$((FAIL+1)); }

echo "=== ArgoCD Fundamentals Lab — Check ==="

[[ -f "$DELIV/argocd/install.yaml" ]] && pass "install.yaml" || fail "install.yaml"
[[ -f "$DELIV/argocd/application-taskflow.yaml" ]] && pass "Application manifest" || fail "Application manifest"
[[ -f "$DELIV/argocd/project-taskflow.yaml" ]] && pass "AppProject manifest" || fail "AppProject manifest"

grep -q 'kind: Application' "$DELIV/argocd/application-taskflow.yaml" && pass "Application CRD" || fail "Application CRD"
grep -q 'repoURL' "$DELIV/argocd/application-taskflow.yaml" && pass "Git repo source" || fail "Git repo source"
grep -q 'syncPolicy' "$DELIV/argocd/application-taskflow.yaml" && pass "Sync policy" || fail "Sync policy"
grep -q 'selfHeal' "$DELIV/argocd/application-taskflow.yaml" && pass "Auto-healing" || fail "Auto-healing"
grep -q 'prune' "$DELIV/argocd/application-taskflow.yaml" && pass "Prune policy" || fail "Prune policy"
grep -q 'sudipto2104' "$DELIV/argocd/application-taskflow.yaml" && pass "GitHub repo link" || fail "GitHub repo link"

[[ -f "$DELIV/manifests/namespace.yaml" ]] && pass "TaskFlow namespace" || fail "TaskFlow namespace"
[[ -f "$DELIV/manifests/api-deployment.yaml" ]] && pass "API deployment" || fail "API deployment"
[[ -f "$DELIV/manifests/api-service.yaml" ]] && pass "API service" || fail "API service"
grep -qiE 'gitops|argocd|sync' "$DELIV/ARGOCD_FUNDAMENTALS_GUIDE.md" && pass "GitOps guide" || fail "GitOps guide"
grep -qiE 'self-heal|health|declarative' "$DELIV/ARGOCD_FUNDAMENTALS_GUIDE.md" && pass "Auto-heal guide" || fail "Auto-heal guide"

echo "Results: $PASS passed, $FAIL failed"
[[ "$FAIL" -eq 0 ]] || { echo "Run ./scripts/solve.sh"; exit 1; }