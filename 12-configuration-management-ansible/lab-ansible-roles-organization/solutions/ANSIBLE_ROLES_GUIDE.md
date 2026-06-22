# Ansible Roles & Organization Guide

## Role structure

```
roles/
  common/       → shared user, packages, directories
  nginx/        → reverse proxy (tasks, handlers, templates)
  postgresql/   → database container scripts
  redis/        → cache container scripts
```

Each role follows Ansible conventions: `tasks/`, `defaults/`, `handlers/`, `templates/`, `meta/`.

## Ansible Galaxy

```bash
cd deliverables
ansible-galaxy install -r requirements.yml -p vendor/roles
```

`geerlingguy.docker` installs and configures Docker — a community role you reuse instead of rewriting.

## Role composition

`playbooks/site.yml` applies roles in order:

1. `common` — foundation
2. `geerlingguy.docker` — container runtime
3. `nginx` — web tier
4. `postgresql` — data tier
5. `redis` — cache tier

Role dependencies in `meta/main.yml` ensure `common` runs before component roles.

## Deploy

```bash
ansible-playbook -i inventory/hosts.ini playbooks/site.yml --syntax-check
ansible-playbook -i inventory/hosts.ini playbooks/site.yml
```

## Best practices

- Keep tasks idempotent (`state: present`, `state: started`)
- Put defaults in `defaults/main.yml`, secrets in Vault (Lab 3)
- Use handlers for service reloads (Nginx)
- Build a personal role library for repeated patterns across projects