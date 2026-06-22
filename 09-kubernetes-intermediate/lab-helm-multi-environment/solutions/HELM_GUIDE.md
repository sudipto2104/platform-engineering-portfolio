# Helm Multi-Environment Guide

## Values hierarchy (2025 pattern)

1. `charts/taskflow/values.yaml` — chart defaults
2. `values-{env}.yaml` — environment overrides (dev → staging → production)
3. `--set` / `--set-file` — CI/CD last-mile overrides

## Render & deploy

```bash
# Dev — minimal replicas
helm template taskflow deliverables/charts/taskflow \
  -f deliverables/values-dev.yaml > /tmp/taskflow-dev.yaml

# Staging — ingress + TLS
helm upgrade --install taskflow deliverables/charts/taskflow \
  -f deliverables/values-staging.yaml -n taskflow-staging --create-namespace

# Production — HA replicas + larger storage
helm diff upgrade taskflow deliverables/charts/taskflow \
  -f deliverables/values-production.yaml  # requires helm-diff plugin
```

## Best practices

- Pin `appVersion` and image tags per environment in production
- Use `{{- if }}` guards for optional subcharts (ingress, postgres)
- Label with `app.kubernetes.io/*` for GitOps compatibility