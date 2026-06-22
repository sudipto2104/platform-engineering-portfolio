#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LAB_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
DELIV="$LAB_DIR/deliverables"
SRC="$LAB_DIR/solutions"
ROLES_SRC="$(cd "$LAB_DIR/../lab-ansible-roles-organization/solutions/roles" && pwd)"

echo "=== Multi-Environment Ansible Lab — Solve ==="
mkdir -p "$DELIV/vault"
cp "$SRC/ansible.cfg" "$SRC/requirements.yml" "$DELIV/"
cp -R "$SRC/inventories" "$SRC/group_vars" "$SRC/playbooks" "$SRC/ci" "$DELIV/"
cp -R "$ROLES_SRC" "$DELIV/roles"
cp "$SRC/vault/secrets.yml.example" "$DELIV/vault/"
cp "$SRC/MULTIENV_DEPLOY_GUIDE.md" "$DELIV/"

if command -v ansible-vault &>/dev/null; then
  cat > /tmp/taskflow-secrets.yml <<'EOF'
---
postgres_password: changeme
redis_password: changeme
api_secret_key: taskflow-dev-secret
EOF
  echo "taskflow-vault-demo" > "$DELIV/.vault_pass"
  ansible-vault encrypt /tmp/taskflow-secrets.yml \
    --output "$DELIV/vault/secrets.yml" \
    --vault-password-file "$DELIV/.vault_pass" 2>/dev/null || \
    cp "$SRC/vault/secrets.yml.example" "$DELIV/vault/secrets.yml"
  rm -f /tmp/taskflow-secrets.yml
else
  cp "$SRC/vault/secrets.yml.example" "$DELIV/vault/secrets.yml"
fi

if command -v ansible-playbook &>/dev/null; then
  (cd "$DELIV" && ansible-playbook -i inventories/dev/hosts.ini playbooks/deploy.yml --syntax-check) 2>&1 | tail -1 || true
fi

echo "→ deliverables/inventories/, vault/, ci/"
echo "Run ./scripts/check.sh"