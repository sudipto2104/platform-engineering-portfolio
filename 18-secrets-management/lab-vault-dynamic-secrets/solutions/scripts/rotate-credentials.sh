#!/usr/bin/env bash
# Rotate TaskFlow dynamic database credentials — revoke leases and re-issue
set -euo pipefail

export VAULT_ADDR="${VAULT_ADDR:-http://127.0.0.1:8200}"
export VAULT_TOKEN="${VAULT_TOKEN:-taskflow-dev-root}"

ROLE="${1:-taskflow-app}"
echo "=== Rotate credentials for role: $ROLE ==="

# List active leases for the role
echo "Active leases:"
vault list "database/creds/$ROLE" 2>/dev/null || echo "(none listed via API)"

# Revoke all leases under the role prefix
echo "Revoking existing leases..."
vault lease revoke -prefix "database/creds/$ROLE" 2>/dev/null || true

# Issue fresh credentials
echo "Issuing new credentials..."
NEW_CREDS=$(vault read -format=json "database/creds/$ROLE")
USERNAME=$(echo "$NEW_CREDS" | jq -r .data.username)
TTL=$(echo "$NEW_CREDS" | jq -r .lease_duration)

echo "New username: $USERNAME"
echo "Lease TTL:    ${TTL}s"

# Optional: renew if needed before expiry
# vault lease renew <lease_id>

echo "Rotation complete. Update application connection strings or restart pods."
echo "Audit log: /vault/audit/taskflow-audit.log"