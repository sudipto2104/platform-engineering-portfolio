#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LAB_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
DELIV="$LAB_DIR/deliverables"
PKG="$DELIV/taskflow_k8s"

PASS=0; FAIL=0
pass() { echo "✓ $1"; PASS=$((PASS+1)); }
fail() { echo "✗ $1"; FAIL=$((FAIL+1)); }

echo "=== Kubernetes Python Client Lab — Check ==="

[[ -f "$DELIV/requirements.txt" ]] && pass "requirements.txt" || fail "requirements.txt"
grep -q 'kubernetes' "$DELIV/requirements.txt" && pass "kubernetes dependency" || fail "kubernetes dependency"

for mod in client_factory pods deployments services workflow; do
  [[ -f "$PKG/${mod}.py" ]] && pass "${mod}.py" || fail "${mod}.py"
done

grep -q 'CoreV1Api\|list_namespaced_pod' "$PKG/pods.py" && pass "Pod operations" || fail "Pod operations"
grep -q 'AppsV1Api\|read_namespaced_deployment' "$PKG/deployments.py" && pass "Deployment operations" || fail "Deployment operations"
grep -q 'CoreV1Api\|list_namespaced_service\|read_namespaced_endpoints' "$PKG/services.py" && pass "Service operations" || fail "Service operations"
grep -q 'deploy_taskflow_stack\|workflow' "$PKG/workflow.py" && pass "Workflow automation" || fail "Workflow automation"
grep -q 'load_kube_config\|load_incluster_config' "$PKG/client_factory.py" && pass "Kubeconfig loading" || fail "Kubeconfig loading"
grep -q 'ApiException' "$PKG/pods.py" && pass "API error handling" || fail "API error handling"
[[ -f "$DELIV/manifests/namespace.yaml" ]] && pass "namespace manifest" || fail "namespace manifest"
grep -qiE 'pod|deployment|service' "$DELIV/KUBERNETES_PYTHON_GUIDE.md" && pass "K8s guide" || fail "K8s guide"
grep -qiE 'self-service|workflow|platform' "$DELIV/KUBERNETES_PYTHON_GUIDE.md" && pass "Platform patterns" || fail "Platform patterns"

echo "Results: $PASS passed, $FAIL failed"
[[ "$FAIL" -eq 0 ]] || { echo "Run ./scripts/solve.sh"; exit 1; }