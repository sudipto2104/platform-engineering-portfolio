# Production GitOps Patterns Guide — TaskFlow

## Progressive delivery

### Canary (TaskFlow API)

`rollouts/canary-rollout.yaml` uses Argo Rollouts with weighted traffic steps: 10% → 30% → 60% → 100% with 2-minute pauses and success-rate analysis.

### Blue-Green (TaskFlow UI)

`rollouts/blue-green-rollout.yaml` deploys to `preview` service, runs health analysis, then promotes to `active` with `autoPromotionEnabled: false` for manual approval.

### A/B testing

Extend canary with header-based traffic routing in the Rollout `trafficRouting` section (nginx/Istio).

## Automated rollback

```bash
argocd app history taskflow-production
./disaster-recovery/rollback.sh taskflow-production 2
```

Failed syncs trigger notifications; operators rollback to last known-good `history` entry.

## Multi-cluster deployments

`ApplicationSet` with cluster generator deploys TaskFlow to every cluster labeled `taskflow-enabled: "true"`:

```bash
kubectl label secret cluster-dev -n argocd taskflow-enabled=true environment=dev
kubectl apply -f argocd/applicationsets/taskflow-multicluster.yaml
```

## Policy-as-code (Kyverno)

`policies/kyverno-taskflow-policy.yaml` enforces:
- Required `app.kubernetes.io/part-of: taskflow` label
- Resource limits in production namespaces

ArgoCD pre-sync hooks can block non-compliant manifests.

## Notifications & audit

`argocd/notifications/notifications-cm.yaml` sends Slack alerts on deploy success and degraded health. Full audit trail in ArgoCD UI History tab.

## Self-service platform

Developers merge to Git → ArgoCD syncs → Kyverno validates → Notifications confirm. No direct `kubectl apply` in production.

## Disaster recovery

See `disaster-recovery/DR_RUNBOOK.md` — Git-backed recovery means redeploying ArgoCD restores entire TaskFlow platform state.

## Verify

```bash
./scripts/check.sh
```