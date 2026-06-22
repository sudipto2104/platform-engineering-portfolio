#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LAB_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
DELIV="$LAB_DIR/deliverables"
SRC="$LAB_DIR/solutions"

echo "=== Ansible Roles Lab — Solve ==="
mkdir -p "$DELIV"
cp "$SRC/ansible.cfg" "$SRC/requirements.yml" "$DELIV/"
cp -R "$SRC/inventory" "$SRC/playbooks" "$SRC/roles" "$DELIV/"
cp "$SRC/ANSIBLE_ROLES_GUIDE.md" "$DELIV/"

if command -v ansible-playbook &>/dev/null; then
  (cd "$DELIV" && ansible-playbook playbooks/site.yml --syntax-check) 2>&1 | tail -1 || true
fi

echo "→ deliverables/roles/, playbooks/, requirements.yml"
echo "Run ./scripts/check.sh"