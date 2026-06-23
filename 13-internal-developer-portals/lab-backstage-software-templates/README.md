# Lab: Backstage Software Templates

Create self-service software templates for platform automation. Build the **New FastAPI Microservice** template that scaffolds complete projects with CI/CD, catalog registration, and GitHub publishing.

## What you build

- `template.yaml` with parameters and scaffolder actions
- Skeleton project with FastAPI boilerplate and GitHub Actions CI
- GitHub OAuth authentication config and RBAC permissions
- Kubernetes, Prometheus, and Grafana integration annotations

## Quick start

```bash
./scripts/solve.sh && ./scripts/check.sh
```

Register the template in `app-config.yaml`:

```yaml
catalog:
  locations:
    - type: file
      target: ../../templates/fastapi-microservice/template.yaml
```