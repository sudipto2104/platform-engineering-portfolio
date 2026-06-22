# Docker Registry Guide

## Naming convention

```
<registry>/<namespace>/<repository>:<tag>
localhost:5001/taskflow-lab/taskflow-api:v1.0.0
```

## Semantic versioning

| Tag | Use |
|-----|-----|
| `latest` | Dev convenience (avoid in prod deploys) |
| `v1.0.0` | Immutable release |
| `v1.0.1` | Patch bump |

## Simulated workflow

```bash
# Start local registry
docker compose -f docker-compose.registry.yml up -d

# Tag, push, pull
./tag-images.sh taskflow-api:week7 taskflow-ui:week7
./push-images.sh

# Offline mock (no registry daemon)
MOCK_MODE=1 ./push-images.sh && MOCK_MODE=1 ./pull-images.sh
```

## Kubernetes prep (Week 8)

Images reference registry host in pod specs:

`image: localhost:5001/taskflow-lab/taskflow-api:v1.0.0`