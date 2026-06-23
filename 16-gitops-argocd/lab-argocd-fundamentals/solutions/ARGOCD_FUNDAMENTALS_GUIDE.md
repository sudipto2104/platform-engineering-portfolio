# ArgoCD Fundamentals Guide — TaskFlow GitOps

## GitOps principles

1. **Declarative** — desired state in Git (manifests in this repo)
2. **Versioned** — Git is the single source of truth
3. **Automated** — ArgoCD syncs cluster to Git automatically
4. **Self-healing** — drift is corrected without manual `kubectl apply`

## Install ArgoCD

```bash
kubectl create namespace argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
kubectl apply -f deliverables/argocd/install.yaml
kubectl apply -f deliverables/argocd/project-taskflow.yaml
```

Access UI:
```bash
kubectl port-forward svc/argocd-server -n argocd 8080:443
# https://localhost:8080  (admin password from argocd-initial-admin-secret)
```

## Deploy TaskFlow via Application CRD

```bash
kubectl apply -f deliverables/argocd/application-taskflow.yaml
argocd app get taskflow
argocd app sync taskflow
```

The Application points at `manifests/` in this GitHub repo. Any commit to `main` triggers reconciliation.

## Sync policy

| Setting | Effect |
|---------|--------|
| `automated.prune` | Remove resources deleted from Git |
| `automated.selfHeal` | Revert manual cluster changes |
| `CreateNamespace=true` | Auto-create `taskflow` namespace |
| `retry` | Exponential backoff on sync failures |

## Auto-healing demo

```bash
kubectl scale deployment taskflow-api -n taskflow --replicas=5
# ArgoCD detects drift and reverts to replicas: 2 from Git
argocd app diff taskflow
```

## Health monitoring

ArgoCD tracks Deployment readiness probes. TaskFlow API `/health` endpoint drives `Healthy` status in the UI.

## Verify

```bash
./scripts/check.sh
kubectl get application -n argocd taskflow
```