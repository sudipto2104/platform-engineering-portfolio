# Lab: Production GitOps Patterns

Implement production-grade GitOps — progressive delivery, automated rollback, multi-cluster deployments, policy-as-code, notifications, and disaster recovery.

## What you build

- Argo Rollouts: Canary and Blue-Green deployment strategies
- Rollback automation via ArgoCD `Application` history
- `ApplicationSet` for multi-cluster TaskFlow sync
- Kyverno policy-as-code governance
- ArgoCD notifications and disaster recovery runbook

## Quick start

```bash
./scripts/solve.sh && ./scripts/check.sh
kubectl apply -f deliverables/policies/
kubectl apply -f deliverables/argocd/applicationsets/
```