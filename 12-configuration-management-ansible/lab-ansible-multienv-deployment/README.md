# Lab: TaskFlow Multi-Environment Deployment (Capstone)

Deploy TaskFlow across dev, staging, and production with environment-specific inventories, Ansible Vault secrets, and a CI/CD pipeline.

## What you build

| Component | Purpose |
|-----------|---------|
| `inventories/{dev,staging,production}/` | Per-environment hosts + vars |
| `vault/secrets.yml` | Encrypted DB passwords and API keys |
| `playbooks/deploy.yml` | Environment-aware stack deploy |
| `ci/ansible-deploy.yml` | GitHub Actions workflow |

## Quick start

```bash
./scripts/solve.sh && ./scripts/check.sh
cd deliverables && ansible-playbook -i inventories/dev/hosts.ini playbooks/deploy.yml --syntax-check
```

See `deliverables/MULTIENV_DEPLOY_GUIDE.md` after solve.