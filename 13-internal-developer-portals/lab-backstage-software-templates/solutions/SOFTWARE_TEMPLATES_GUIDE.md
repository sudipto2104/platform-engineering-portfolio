# Software Templates Guide — TaskFlow Platform Automation

## Overview

Backstage Scaffolder turns `template.yaml` definitions into self-service workflows. The **New FastAPI Microservice** template automates:

1. **fetch:template** — Copy skeleton with parameter substitution
2. **publish:github** — Create repo under `sudipto2104`
3. **catalog:register** — Auto-register `catalog-info.yaml` in the service catalog

## Register the template

Add to `app-config.yaml`:

```yaml
catalog:
  locations:
    - type: file
      target: ../../templates/fastapi-microservice/template.yaml
```

Restart Backstage, then open **Create** → **New FastAPI Microservice**.

## Template parameters

| Parameter | Purpose |
|-----------|---------|
| `serviceName` | Kebab-case service identifier |
| `owner` | Catalog owner (team or user) |
| `description` | Shown in catalog and GitHub repo |
| `repoUrl` | GitHub destination via RepoUrlPicker |
| `environment` | dev / staging / production tag |

## GitHub integration

1. Create a GitHub OAuth App → set callback `http://localhost:7007/api/auth/github/handler/frame`
2. Set `GITHUB_TOKEN`, `AUTH_GITHUB_CLIENT_ID`, `AUTH_GITHUB_CLIENT_SECRET`
3. Merge `app-config.auth-rbac.yaml` for OAuth + RBAC

RBAC grants `platform-team` scaffolder execute permissions; guests get read-only catalog access.

## Kubernetes integration

Skeleton includes `k8s-deployment.yaml` with `backstage.io/kubernetes-id` label matching catalog annotations. The Kubernetes plugin (configured in Lab 1) shows pod status on the entity page.

```bash
kubectl apply -f k8s-deployment.yaml -n taskflow
```

## Monitoring integrations

| Tool | Integration | Annotation |
|------|-------------|------------|
| Prometheus | Proxy `/prometheus` | `prometheus.io/rule` on catalog entity |
| Grafana | Proxy `/grafana` | `grafana/dashboard-selector` annotation |
| TaskFlow API | Proxy `/taskflow-api` | Used by Dashboard plugin (Lab 2) |

## Verify

```bash
./scripts/check.sh
```

In Backstage UI: **Create** → fill parameters → verify GitHub repo created and entity appears in Catalog.