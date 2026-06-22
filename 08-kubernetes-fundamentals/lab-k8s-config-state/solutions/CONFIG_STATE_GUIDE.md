# Config & State Guide

## 12-factor configuration

- **ConfigMap** — non-secret env (`APP_ENV`, hostnames)
- **Secret** — credentials (`POSTGRES_PASSWORD`, connection URLs)
- **StatefulSet + PVC** — Postgres data survives pod restart
- **Deployment** — Redis stateless (ephemeral OK for lab cache)

## Persistence test

```bash
kubectl exec -n taskflow-lab2 postgres-0 -- psql -U taskflow -c "CREATE TABLE IF NOT EXISTS ping(id int);"
kubectl delete pod postgres-0 -n taskflow-lab2
kubectl wait --for=condition=ready pod -l app=postgres -n taskflow-lab2
# Table should still exist — data on PVC
```

## Env injection

Backend uses `envFrom` + `secretKeyRef` for `DATABASE_URL` and `REDIS_URL`.