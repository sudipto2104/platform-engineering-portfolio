# TaskFlow Web Stack Status (Reference)

## Components

| Service | Role | Port | Health check |
|---------|------|------|--------------|
| nginx | Reverse proxy | 80 / 8088 (compose) | `GET /health` via proxy |
| TaskFlow | API (Gunicorn) | 8080 | `/health` JSON |
| PostgreSQL | Persistence (Week 6+) | 5432 | `pg_isready` |
| Redis | Cache layer (Week 6+) | 6379 | `redis-cli ping` |

## Docker Compose verification

```bash
docker compose ps
curl -s http://localhost:8088/health
curl -s http://localhost:8088/api/tasks
```

## systemd verification (Ubuntu)

```bash
systemctl is-active nginx postgresql redis taskflow
```

## Week 11 Ansible preview

This stack becomes playbooks:

- `roles/nginx/tasks/main.yml`
- `roles/postgresql/tasks/main.yml`
- `roles/taskflow/tasks/main.yml`

Variables: `taskflow_version`, `db_password`, `worker_count`.