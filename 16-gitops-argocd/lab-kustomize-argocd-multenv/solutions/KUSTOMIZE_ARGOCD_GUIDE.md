# Kustomize + ArgoCD Multi-Environment Guide

## Structure

```
kustomize/
├── base/           # Shared TaskFlow manifests
└── overlays/
    ├── dev/        # 1 replica, debug logging
    ├── staging/    # 2 replicas
    └── production/ # 3 replicas, higher limits
```

## Preview overlays

```bash
kubectl kustomize deliverables/kustomize/overlays/dev
kubectl kustomize deliverables/kustomize/overlays/staging
kubectl kustomize deliverables/kustomize/overlays/production
```

## Environment differences

| Env | Namespace | API Replicas | UI Replicas | Notes |
|-----|-----------|--------------|-------------|-------|
| dev | taskflow-dev | 1 | 1 | `LOG_LEVEL=debug` |
| staging | taskflow-staging | 2 | 2 | Pre-prod validation |
| production | taskflow-production | 3 | 3 | Higher CPU limits |

## ArgoCD Applications

One Application per environment — each points at a Kustomize overlay path:

```bash
kubectl apply -f deliverables/argocd/applications/
argocd app list
argocd app sync taskflow-dev
```

ArgoCD natively supports Kustomize — no `helm template` or `kustomize build` step required.

## Promotion workflow

1. Change `base/` manifests → affects all environments
2. Change overlay patch → environment-specific only
3. Merge PR to `main` → ArgoCD auto-syncs per Application policy
4. Promote staging → production by merging overlay changes

## Verify

```bash
./scripts/check.sh
```