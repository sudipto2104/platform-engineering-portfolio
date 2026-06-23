# Vault Dynamic Secrets Guide — TaskFlow

## Why dynamic secrets?

Static K8s Secrets (Week 8) never expire. Vault database engine generates **short-lived credentials** with automatic revocation — reducing blast radius if leaked.

## Database engine setup

```bash
./scripts/setup-database-engine.sh
vault read database/creds/taskflow-app
```

Returns:
```json
{
  "username": "v-token-taskflow-a-abc123",
  "password": "A1b2C3-d4e5F6",
  "lease_duration": 3600
}
```

## Lease management

| Operation | Command |
|-----------|---------|
| Read creds | `vault read database/creds/taskflow-app` |
| Renew lease | `vault lease renew <lease_id>` |
| Revoke lease | `vault lease revoke <lease_id>` |
| Rotate all | `./scripts/rotate-credentials.sh taskflow-app` |

## TTL configuration

| Role | default_ttl | max_ttl | Permissions |
|------|-------------|---------|-------------|
| `taskflow-app` | 1h | 4h | Read/write |
| `taskflow-readonly` | 30m | 2h | SELECT only |

Vault Agent auto-renews leases before expiry when injected into pods.

## Compliance controls

- **Audit log** — `vault audit enable file` records every credential issuance
- **Deny static paths** — `taskflow-compliance` policy blocks KV database secrets
- **Revocation on rotation** — `rotate-credentials.sh` revokes prefix before re-issue
- **VALID UNTIL** — PostgreSQL roles expire at SQL level matching Vault TTL

## Kubernetes integration

`taskflow-api-dynamic-db.yaml` injects `database/creds/taskflow-app` via Vault Agent — app never stores long-lived DB passwords.

```bash
kubectl apply -f k8s/taskflow-api-dynamic-db.yaml
kubectl exec -n taskflow deploy/taskflow-api-dynamic -- env | grep DATABASE_URL
```

## Verify

```bash
./scripts/check.sh
vault read database/creds/taskflow-app
```