# Lab: Kustomize + ArgoCD Multi-Environment

Master Kustomize overlays for dev, staging, and production TaskFlow deployments managed by ArgoCD.

## What you build

- Kustomize `base/` with shared TaskFlow manifests
- Environment overlays: `dev`, `staging`, `production`
- One ArgoCD `Application` per environment
- Replica and resource patches per environment

## Quick start

```bash
./scripts/solve.sh && ./scripts/check.sh
kubectl kustomize deliverables/kustomize/overlays/dev
kubectl apply -f deliverables/argocd/applications/
```