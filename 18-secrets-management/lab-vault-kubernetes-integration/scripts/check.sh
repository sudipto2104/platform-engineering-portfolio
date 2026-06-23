#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LAB_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
DELIV="$LAB_DIR/deliverables"

PASS=0; FAIL=0
pass() { echo "✓ $1"; PASS=$((PASS+1)); }
fail() { echo "✗ $1"; FAIL=$((FAIL+1)); }

echo "=== Vault Kubernetes Integration Lab — Check ==="

[[ -f "$DELIV/vault/kubernetes-auth-config.sh" ]] && pass "K8s auth config" || fail "K8s auth config"
[[ -f "$DELIV/k8s/auth/serviceaccount.yaml" ]] && pass "ServiceAccount" || fail "ServiceAccount"
[[ -f "$DELIV/k8s/agent/taskflow-api-vault-agent.yaml" ]] && pass "Vault Agent deployment" || fail "Vault Agent deployment"
[[ -f "$DELIV/k8s/csi/secret-provider-class.yaml" ]] && pass "CSI provider" || fail "CSI provider"

grep -q 'auth/kubernetes\|kubernetes' "$DELIV/vault/kubernetes-auth-config.sh" && pass "Kubernetes auth method" || fail "Kubernetes auth method"
grep -q 'vault.hashicorp.com/agent-inject' "$DELIV/k8s/agent/taskflow-api-vault-agent.yaml" && pass "Agent injector annotations" || fail "Agent injector annotations"
grep -q 'vault.hashicorp.com/role' "$DELIV/k8s/agent/taskflow-api-vault-agent.yaml" && pass "Vault role binding" || fail "Vault role binding"
grep -q 'SecretProviderClass' "$DELIV/k8s/csi/secret-provider-class.yaml" && pass "SecretProviderClass CRD" || fail "SecretProviderClass CRD"
grep -q 'secrets-store.csi' "$DELIV/k8s/csi/secret-provider-class.yaml" && pass "CSI driver reference" || fail "CSI driver reference"
grep -q 'taskflow-api' "$DELIV/k8s/auth/serviceaccount.yaml" && pass "TaskFlow SA" || fail "TaskFlow SA"
grep -qiE 'kubernetes|sidecar|agent' "$DELIV/VAULT_KUBERNETES_GUIDE.md" && pass "K8s integration guide" || fail "K8s integration guide"
grep -qiE 'csi|inject' "$DELIV/VAULT_KUBERNETES_GUIDE.md" && pass "CSI/injector guide" || fail "CSI/injector guide"

echo "Results: $PASS passed, $FAIL failed"
[[ "$FAIL" -eq 0 ]] || { echo "Run ./scripts/solve.sh"; exit 1; }