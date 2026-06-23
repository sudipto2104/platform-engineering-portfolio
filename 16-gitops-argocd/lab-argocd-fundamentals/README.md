# Lab: ArgoCD Fundamentals

Install ArgoCD, connect your Git repository, and deploy TaskFlow declaratively with automated sync and self-healing.

## What you build

- ArgoCD namespace and install manifest reference
- `Application` CRD pointing at TaskFlow K8s manifests in Git
- Sync policy with `prune` and `selfHeal`
- Health monitoring and GitOps workflow guide

## Quick start

```bash
./scripts/solve.sh && ./scripts/check.sh
kubectl create namespace argocd
kubectl apply -n argocd -f deliverables/argocd/install.yaml
kubectl apply -f deliverables/argocd/application-taskflow.yaml
```

See `deliverables/ARGOCD_FUNDAMENTALS_GUIDE.md` after solve.