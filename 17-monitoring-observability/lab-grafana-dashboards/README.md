# Lab: Grafana Dashboards

Create production Grafana dashboards for TaskFlow with variables, templating, and provisioning-as-code.

## What you build

- `taskflow-overview.json` dashboard with panels and template variables
- Datasource and dashboard provisioning configs
- Environment and service variable selectors

## Quick start

```bash
./scripts/solve.sh && ./scripts/check.sh
kubectl port-forward -n monitoring svc/prometheus-grafana 3000:80
# Import deliverables/grafana/dashboards/taskflow-overview.json
```