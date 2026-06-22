# Lab: Ansible Roles & Organization

Transform monolithic playbooks into reusable roles for TaskFlow infrastructure — Nginx, PostgreSQL, and Redis — with Ansible Galaxy dependencies.

## What you build

| Role | Responsibility |
|------|----------------|
| `common` | Base dirs, packages, TaskFlow user |
| `nginx` | Reverse proxy with handlers |
| `postgresql` | PostgreSQL container config |
| `redis` | Redis cache container config |

## Quick start

```bash
./scripts/solve.sh && ./scripts/check.sh
ansible-galaxy install -r deliverables/requirements.yml
ansible-playbook -i deliverables/inventory/hosts.ini deliverables/playbooks/site.yml --syntax-check
```