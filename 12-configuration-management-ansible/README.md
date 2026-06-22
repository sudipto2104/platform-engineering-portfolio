# Week 12: Ansible Configuration Management

**Slug:** `ansible-configuration-management`

Automate TaskFlow server configuration with Ansible — fundamentals, reusable roles, and multi-environment deployments.

Builds on [`../11-infrastructure-as-code-terraform/`](../11-infrastructure-as-code-terraform/) (provision EC2 with Terraform, configure with Ansible).

## Labs

| Directory | Focus |
|-----------|--------|
| [`lab-ansible-fundamentals/`](./lab-ansible-fundamentals/) | Inventory, playbooks, core modules, idempotency |
| [`lab-ansible-roles-organization/`](./lab-ansible-roles-organization/) | Roles for Nginx, PostgreSQL, Redis; Galaxy |
| [`lab-ansible-multienv-deployment/`](./lab-ansible-multienv-deployment/) | Capstone — dev/staging/prod, Vault, CI/CD |

Each lab includes `scripts/check.sh` and `scripts/solve.sh`.

## Quick start

```bash
cd lab-ansible-fundamentals && ./scripts/solve.sh && ./scripts/check.sh
```

## Status

Week 12 complete — 3 Ansible labs, TaskFlow configuration automation.