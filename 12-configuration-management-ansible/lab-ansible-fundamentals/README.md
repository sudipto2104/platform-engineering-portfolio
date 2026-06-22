# Lab: Ansible Fundamentals

Replace manual SSH with declarative playbooks. Configure TaskFlow application servers using inventory, core modules, and idempotent tasks.

## What you build

- Static inventory with `taskflow_app` server group
- Playbooks using `yum`, `copy`, `template`, `service`, `user`, `file`
- Nginx reverse proxy + Docker bootstrap for TaskFlow

## Quick start

```bash
./scripts/solve.sh && ./scripts/check.sh
ansible-playbook -i deliverables/inventory/hosts.ini deliverables/playbooks/site.yml --syntax-check
```

See `deliverables/ANSIBLE_FUNDAMENTALS_GUIDE.md` after solve.