# Docker Compose Guide

## Services

| Service | Image/Build | Volume | Health |
|---------|-------------|--------|--------|
| postgres | postgres:16-alpine | `taskflow_pg_data` | `pg_isready` |
| redis | redis:7-alpine | `taskflow_redis_data` | `redis-cli ping` |
| backend | TaskFlow FastAPI | — | `/health` |
| frontend | Vue + Nginx | — | wget `/` |

## Commands

```bash
docker compose --env-file config/taskflow.env up -d
docker compose ps
curl http://localhost:8080/health
./backup-volumes.sh
```

## Env banner

Frontend `EnvBanner.vue` reads `VITE_APP_ENV` baked in at build via Compose build args.