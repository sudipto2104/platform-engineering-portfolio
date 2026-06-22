# Week 7: Docker Fundamentals

**Slug:** `docker-fundamentals`

Containerize TaskFlow — Dockerfiles for frontend and backend, Docker Compose full stack, and registry publish workflows.

## TaskFlow stack

Week 7 builds on Week 6 code reading. Shared application source: [`taskflow-stack/`](./taskflow-stack/).

## Labs

| Directory | Focus |
|-----------|--------|
| [`lab-dockerfile-containerization/`](./lab-dockerfile-containerization/) | Multi-stage Vue+Nginx Dockerfile, FastAPI backend + health checks |
| [`lab-docker-compose-stack/`](./lab-docker-compose-stack/) | 4-service Compose, volumes, backup/restore, env display |
| [`lab-docker-registry/`](./lab-docker-registry/) | Image tagging, simulated registry push/pull |

Each lab includes `scripts/check.sh` and `scripts/solve.sh`.

## Quick start

```bash
cd lab-dockerfile-containerization && ./scripts/solve.sh && ./scripts/check.sh
```

## Status

Week 7 complete — 3 labs, TaskFlow stack, check/solve scripts.