# TaskFlow Ansible (Week 12)

| Layer | Ansible artifact | Configures |
|-------|------------------|------------|
| Inventory | `taskflow_app` group | EC2 app servers from Week 11 |
| Playbooks | `taskflow-servers.yml` | Docker, Nginx reverse proxy |
| Roles | `nginx`, `postgresql`, `redis` | Reusable TaskFlow stack components |
| Multi-env | `inventories/{dev,staging,production}` | Environment-specific vars |
| Secrets | Ansible Vault | DB passwords, API keys |
| CI/CD | GitHub Actions workflow | Automated deploy on merge |

Flow: **Terraform provisions** → **Ansible configures** → **TaskFlow runs**.