# Disaster Recovery Runbook — TaskFlow GitOps

## Recovery objectives

| Metric | Target |
|--------|--------|
| RPO (Recovery Point Objective) | 1 hour (Git state) |
| RTO (Recovery Time Objective) | 30 minutes (cluster rebuild) |

## Scenario 1: Bad deployment — automated rollback

```bash
argocd app history taskflow-production
./rollback.sh taskflow-production 3
```

ArgoCD `revisionHistoryLimit` preserves prior Git SHAs for instant rollback.

## Scenario 2: Cluster loss — rebuild from Git

1. Provision new cluster (Terraform Week 11)
2. Install ArgoCD: `kubectl apply -n argocd -f install.yaml`
3. Restore cluster secrets: `kubectl apply -f cluster-secrets/`
4. Apply ApplicationSets: `kubectl apply -f argocd/applicationsets/`
5. ArgoCD syncs all TaskFlow apps from Git — **Git is the source of truth**

## Scenario 3: Git repository corruption

- Restore from GitHub (protected `main` branch)
- Tag known-good releases: `git tag release/v1.2.0`
- ArgoCD `targetRevision: release/v1.2.0` for pin

## Backup checklist

- [ ] Git repo with protected branches
- [ ] ArgoCD export: `argocd admin export > argocd-backup.yaml`
- [ ] Kubernetes etcd snapshots (managed cluster)
- [ ] Secrets in Vault (Week 18 preview)

## Audit trail

ArgoCD UI → Application → History shows who synced what and when. Enable Git commit signing for full traceability.