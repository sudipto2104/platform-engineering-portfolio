# Ansible Fundamentals Guide

## Install Ansible

```bash
pip install ansible
ansible --version
```

## Project layout

```
inventory/hosts.ini       → server groups (taskflow_app)
inventory/group_vars/     → variables per group
playbooks/site.yml        → entry playbook
playbooks/taskflow-servers.yml
templates/                → Jinja2 configs (Nginx)
files/                    → static files (docker-compose)
ansible.cfg               → defaults
```

## Core workflow

```bash
cd deliverables
ansible taskflow_app -m ping -i inventory/hosts.ini
ansible-playbook playbooks/site.yml --check    # dry run
ansible-playbook playbooks/site.yml            # apply
ansible-playbook playbooks/site.yml            # run again — no changes (idempotent)
```

## Modules used

| Module | Purpose |
|--------|---------|
| `yum` | Install Docker, Nginx, Git |
| `user` / `group` | TaskFlow service account |
| `file` | Create `/opt/taskflow` |
| `copy` | Deploy docker-compose |
| `template` | Render Nginx config |
| `service` | Start/enable Docker + Nginx |

## Idempotency

Ansible compares desired state to actual state. A second `ansible-playbook` run reports **changed=0** when servers are already configured — this is why idempotency matters for reliable automation.

## TaskFlow context

Targets EC2 app servers (`10.30.10.x`) provisioned in Week 11 Terraform. Replaces manual SSH from Week 10 EC2 deploy lab.