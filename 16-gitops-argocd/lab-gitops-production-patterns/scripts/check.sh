#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LAB_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
DELIV="$LAB_DIR/deliverables"

PASS=0; FAIL=0
pass() { echo "✓ $1"; PASS=$((PASS+1)); }
fail() { echo "✗ $1"; FAIL=$((FAIL+1)); }

echo "=== GitOps Production Patterns Lab — Check ==="

[[ -f "$DELIV/rollouts/canary-rollout.yaml" ]] && pass "Canary rollout" || fail "Canary rollout"
[[ -f "$DELIV/rollouts/blue-green-rollout.yaml" ]] && pass "Blue-green rollout" || fail "Blue-green rollout"
grep -q 'canary\|Canary' "$DELIV/rollouts/canary-rollout.yaml" && pass "Canary strategy" || fail "Canary strategy"
grep -q 'blueGreen\|activeService' "$DELIV/rollouts/blue-green-rollout.yaml" && pass "Blue-green strategy" || fail "Blue-green strategy"

[[ -f "$DELIV/argocd/applicationsets/taskflow-multicluster.yaml" ]] && pass "ApplicationSet" || fail "ApplicationSet"
grep -q 'ApplicationSet' "$DELIV/argocd/applicationsets/taskflow-multicluster.yaml" && pass "Multi-cluster" || fail "Multi-cluster"
grep -q 'clusters\|generators' "$DELIV/argocd/applicationsets/taskflow-multicluster.yaml" && pass "Cluster generators" || fail "Cluster generators"

[[ -f "$DELIV/policies/kyverno-taskflow-policy.yaml" ]] && pass "Kyverno policy" || fail "Kyverno policy"
grep -q 'ClusterPolicy\|Policy' "$DELIV/policies/kyverno-taskflow-policy.yaml" && pass "Policy-as-code" || fail "Policy-as-code"

[[ -f "$DELIV/argocd/notifications/notifications-cm.yaml" ]] && pass "Notifications config" || fail "Notifications config"
grep -q 'trigger\|template\|slack\|email' "$DELIV/argocd/notifications/notifications-cm.yaml" && pass "Alert templates" || fail "Alert templates"

[[ -f "$DELIV/disaster-recovery/DR_RUNBOOK.md" ]] && pass "DR runbook" || fail "DR runbook"
[[ -f "$DELIV/disaster-recovery/rollback.sh" ]] && pass "Rollback script" || fail "Rollback script"
grep -q 'rollback\|history' "$DELIV/disaster-recovery/rollback.sh" && pass "Rollback automation" || fail "Rollback automation"

grep -qiE 'canary|blue-green|progressive' "$DELIV/GITOPS_PRODUCTION_GUIDE.md" && pass "Progressive delivery guide" || fail "Progressive delivery guide"
grep -qiE 'multi-cluster|policy|disaster' "$DELIV/GITOPS_PRODUCTION_GUIDE.md" && pass "Production patterns guide" || fail "Production patterns guide"
grep -qiE 'notification|audit|self-service' "$DELIV/GITOPS_PRODUCTION_GUIDE.md" && pass "Platform ops guide" || fail "Platform ops guide"

echo "Results: $PASS passed, $FAIL failed"
[[ "$FAIL" -eq 0 ]] || { echo "Run ./scripts/solve.sh"; exit 1; }