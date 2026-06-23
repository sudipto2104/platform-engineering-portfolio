#!/usr/bin/env bash
# Enable Vault database secrets engine for TaskFlow PostgreSQL
set -euo pipefail

export VAULT_ADDR="${VAULT_ADDR:-http://127.0.0.1:8200}"
export VAULT_TOKEN="${VAULT_TOKEN:-taskflow-dev-root}"

echo "=== TaskFlow Database Secrets Engine ==="

vault secrets enable database 2>/dev/null || echo "database engine already enabled"

vault write database/config/taskflow-postgres @vault/database-engine-config.json

# Application role — read/write, 1h TTL, 4h max
vault write database/roles/taskflow-app \
  db_name=taskflow-postgres \
  creation_statements="CREATE ROLE \"{{name}}\" WITH LOGIN PASSWORD '{{password}}' VALID UNTIL '{{expiration}}'; \
    GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA public TO \"{{name}}\";" \
  revocation_statements="REVOKE ALL PRIVILEGES ON ALL TABLES IN SCHEMA public FROM \"{{name}}\"; \
    DROP ROLE IF EXISTS \"{{name}}\";" \
  default_ttl=1h \
  max_ttl=4h

# Read-only role for reporting
vault write database/roles/taskflow-readonly \
  db_name=taskflow-postgres \
  creation_statements="CREATE ROLE \"{{name}}\" WITH LOGIN PASSWORD '{{password}}' VALID UNTIL '{{expiration}}'; \
    GRANT SELECT ON ALL TABLES IN SCHEMA public TO \"{{name}}\";" \
  default_ttl=30m \
  max_ttl=2h

vault policy write taskflow-db-dynamic policies/taskflow-db-dynamic.hcl
vault policy write taskflow-compliance policies/taskflow-compliance.hcl

# Enable file audit log for compliance
vault audit enable file file_path=/vault/audit/taskflow-audit.log 2>/dev/null || true

echo "Generate dynamic credentials:"
vault read database/creds/taskflow-app