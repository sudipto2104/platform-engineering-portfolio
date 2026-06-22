# TaskFlow Multi-Environment Deploy Guide

Deploy the complete TaskFlow stack to **dev**, **staging**, or **production** with one playbook and environment-specific inventories.

## Layout

```
inventories/dev/hosts.ini
inventories/staging/hosts.ini
inventories/production/hosts.ini
group_vars/{all,dev,staging,production}.yml
vault/secrets.yml          → Ansible Vault (encrypted)
playbooks/deploy.yml       → single entry playbook
ci/ansible-deploy.yml      → GitHub Actions pipeline
```

## Ansible Vault

```bash
cd deliverables
cp vault/secrets.yml.example vault/secrets.yml
ansible-vault encrypt vault/secrets.yml
echo "your-vault-password" > .vault_pass   # local only — never commit
```

Store `ANSIBLE_VAULT_PASSWORD` in GitHub repository secrets for CI.

## Deploy per environment

```bash
# Dev
ansible-playbook -i inventories/dev/hosts.ini playbooks/deploy.yml --vault-password-file .vault_pass

# Staging
ansible-playbook -i inventories/staging/hosts.ini playbooks/deploy.yml --vault-password-file .vault_pass

# Production
ansible-playbook -i inventories/production/hosts.ini playbooks/deploy.yml --vault-password-file .vault_pass
```

Each run applies the same roles with environment-specific variables from `group_vars/`.

## CI/CD integration

Copy `ci/ansible-deploy.yml` to `.github/workflows/taskflow-ansible-deploy.yml`.

- **Push to main** → syntax check against dev inventory
- **workflow_dispatch** → deploy to chosen environment with Vault secrets

## Production hosts

Production inventory uses Week 11 Terraform EC2 private app tier (`10.30.10.x`). Dev/staging use separate subnets for safe iteration.