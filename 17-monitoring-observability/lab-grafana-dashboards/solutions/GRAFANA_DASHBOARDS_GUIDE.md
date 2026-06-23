# Grafana Dashboards Guide — TaskFlow

## Dashboard-as-code

`grafana/dashboards/taskflow-overview.json` defines:
- **Stat panels** — API health, task count
- **Gauge** — active users
- **Time series** — request rate, p95 latency
- **Variables** — `$namespace` (environment), `$service` (component)

## Template variables

| Variable | Type | Purpose |
|----------|------|---------|
| `namespace` | Query | Switch between taskflow-dev/staging/production |
| `service` | Custom | Filter by taskflow-api, ui, exporter |

Variables propagate to all panel PromQL expressions via `$namespace` and `$service`.

## Provisioning

Mount provisioning configs in Grafana:

```yaml
# Helm values snippet
grafana:
  dashboardProviders:
    dashboardproviders.yaml:
      apiVersion: 1
      providers:
        - name: taskflow
          folder: TaskFlow
          type: file
          options:
            path: /var/lib/grafana/dashboards/taskflow
  dashboards:
    taskflow:
      taskflow-overview:
        file: dashboards/taskflow-overview.json
```

Or apply `grafana/provisioning/*.yaml` via ConfigMap.

## Import manually

1. Open Grafana → Dashboards → Import
2. Upload `taskflow-overview.json`
3. Select Prometheus datasource

## Production tips

- Set `editable: false` on production dashboards
- Use folder RBAC for team access
- Version dashboards in Git (this repo)
- Link from Backstage catalog (`grafana/dashboard-selector: taskflow-overview`)

## Verify

```bash
./scripts/check.sh
```