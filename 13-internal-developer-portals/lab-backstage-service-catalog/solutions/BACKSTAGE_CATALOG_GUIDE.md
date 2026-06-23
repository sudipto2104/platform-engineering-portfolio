# Backstage Service Catalog Guide — TaskFlow

## Backstage architecture

```
┌─────────────────────────────────────────────────────────┐
│  Frontend (React)     packages/app                      │
│  ├── Core plugins     catalog, scaffolder, techdocs     │
│  └── Custom plugins   taskflow-dashboard (Week 13 Lab 2)  │
├─────────────────────────────────────────────────────────┤
│  Backend (Node.js)    packages/backend                  │
│  ├── Catalog processor                                  │
│  ├── Auth (GitHub OAuth)                                │
│  ├── Kubernetes plugin                                  │
│  └── Proxy (Prometheus, Grafana, TaskFlow API)          │
├─────────────────────────────────────────────────────────┤
│  Data layer             SQLite (dev) / PostgreSQL (prod)│
└─────────────────────────────────────────────────────────┘
```

## Install Backstage

```bash
npx @backstage/create-app@latest
# App ID: taskflow-portal
cd taskflow-portal
yarn install
```

Copy `catalog/*.yaml` and `workspace/app-config.yaml` into your app, adjusting catalog location paths.

## Entity model for TaskFlow

| Entity | Kind | Name | Relationships |
|--------|------|------|---------------|
| TaskFlow Platform | Domain | `taskflow-platform` | Owns System |
| TaskFlow | System | `taskflow` | Contains all components |
| Frontend | Component | `taskflow-frontend` | dependsOn backend, redis; consumesApis |
| Backend | Component | `taskflow-backend` | providesApis; dependsOn postgres, redis |
| REST API | API | `taskflow-rest-api` | Provided by backend |
| PostgreSQL | Resource | `taskflow-postgres` | dependencyOf backend |
| Redis | Resource | `taskflow-redis` | dependencyOf backend, frontend |

## Register catalog entities

1. Place YAML files in `catalog/` (or a dedicated repo).
2. Add file locations in `app-config.yaml` under `catalog.locations`.
3. Start Backstage: `yarn dev`
4. Open **Catalog** → verify all 7 entities appear with relationship graph.

## GitHub integration

Set environment variables:

```bash
export GITHUB_TOKEN=ghp_...
export AUTH_GITHUB_CLIENT_ID=...
export AUTH_GITHUB_CLIENT_SECRET=...
```

Annotations on components link to source:

```yaml
annotations:
  github.com/project-slug: sudipto2104/platform-engineering-portfolio
  backstage.io/source-location: url:https://github.com/sudipto2104/...
```

## Kubernetes & monitoring links

- `backstage.io/kubernetes-id` — matches K8s Deployment label from Week 8 manifests
- `backstage.io/kubernetes-namespace: taskflow`
- Proxy endpoints in `app-config.yaml` for Prometheus (`:9090`) and Grafana (`:3001`)

## Verify

```bash
./scripts/check.sh
curl http://localhost:7007/api/catalog/entities | jq '.[] | select(.metadata.name | startswith("taskflow"))'
```