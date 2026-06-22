#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LAB_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
DELIV="$LAB_DIR/deliverables"

PASS=0; FAIL=0
pass() { echo "✓ $1"; PASS=$((PASS+1)); }
fail() { echo "✗ $1"; FAIL=$((FAIL+1)); }

echo "=== RBAC Namespace Security Lab — Check ==="

grep -q 'taskflow-dev' "$DELIV/namespaces.yaml" && pass "Dev namespace" || fail "Dev ns"
grep -q 'taskflow-staging' "$DELIV/namespaces.yaml" && pass "Staging namespace" || fail "Staging ns"
grep -q 'taskflow-prod' "$DELIV/namespaces.yaml" && pass "Prod namespace" || fail "Prod ns"
grep -q 'pod-security.kubernetes.io' "$DELIV/namespaces.yaml" && pass "PSS labels" || fail "PSS"

grep -q 'kind: Role' "$DELIV/rbac.yaml" && pass "Roles defined" || fail "Roles"
grep -q 'kind: RoleBinding' "$DELIV/rbac.yaml" && pass "RoleBindings" || fail "RoleBindings"
grep -q 'resourceNames' "$DELIV/rbac.yaml" && pass "Least privilege resourceNames" || fail "Least privilege"

grep -q 'NetworkPolicy' "$DELIV/network-policy.yaml" && pass "NetworkPolicy" || fail "NetworkPolicy"
grep -q 'runAsNonRoot' "$DELIV/pod-security.yaml" && pass "Pod security context" || fail "Pod security"
grep -q 'allowPrivilegeEscalation: false' "$DELIV/pod-security.yaml" && pass "Hardened container" || fail "Container security"

grep -qiE 'namespace|RBAC|least.privilege' "$DELIV/SECURITY_GUIDE.md" && pass "Security guide" || fail "Guide"

echo "Results: $PASS passed, $FAIL failed"
[[ "$FAIL" -eq 0 ]] || { echo "Run ./scripts/solve.sh"; exit 1; }