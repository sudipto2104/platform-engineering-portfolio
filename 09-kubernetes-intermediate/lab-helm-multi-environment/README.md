# Lab: Helm Multi-Environment Deployment

Package TaskFlow as a Helm 3 chart and deploy with environment-specific values (dev, staging, production).

```bash
./scripts/solve.sh && ./scripts/check.sh
helm template taskflow deliverables/charts/taskflow -f deliverables/values-production.yaml
```