# Lab: Vault Dynamic Secrets

Generate short-lived PostgreSQL credentials for TaskFlow, manage leases, automate rotation, and implement compliance controls.

## What you build

- Database secrets engine configuration for TaskFlow Postgres
- Dynamic credential roles with TTL and max TTL
- Rotation script and lease revocation policies
- Compliance audit policy and K8s deployment using dynamic creds

## Quick start

```bash
./scripts/solve.sh && ./scripts/check.sh
./deliverables/scripts/setup-database-engine.sh
# See deliverables/VAULT_DYNAMIC_SECRETS_GUIDE.md
```