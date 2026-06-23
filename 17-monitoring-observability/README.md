# Week 17: Monitoring & Observability — Prometheus & Grafana

**Slug:** `monitoring-observability-prometheus-grafana`

Build a production-ready TaskFlow observability stack — Prometheus metrics collection, Grafana dashboards, AlertManager routing, and self-healing monitoring agents.

Builds on [`../08-kubernetes-fundamentals/`](../08-kubernetes-fundamentals/) (TaskFlow K8s), [`../16-gitops-argocd/`](../16-gitops-argocd/) (GitOps deploys), and [`../14-python-platform-engineering-part-1/`](../14-python-platform-engineering-part-1/) (Python automation).

## Labs

| Directory | Focus |
|-----------|--------|
| [`lab-prometheus-metrics-collection/`](./lab-prometheus-metrics-collection/) | Prometheus install, K8s SD, custom exporter, PromQL, retention |
| [`lab-grafana-dashboards/`](./lab-grafana-dashboards/) | Grafana dashboards, variables, templating, provisioning |
| [`lab-alertmanager-routing/`](./lab-alertmanager-routing/) | AlertManager rules, routing, notification channels |
| [`lab-monitoring-agent-self-healing/`](./lab-monitoring-agent-self-healing/) | Self-healing agent, threshold alerts, automated remediation |

Each lab includes `scripts/check.sh` and `scripts/solve.sh`.

## Quick start

```bash
cd lab-prometheus-metrics-collection && ./scripts/solve.sh && ./scripts/check.sh
cd ../lab-grafana-dashboards && ./scripts/solve.sh && ./scripts/check.sh
cd ../lab-alertmanager-routing && ./scripts/solve.sh && ./scripts/check.sh
cd ../lab-monitoring-agent-self-healing && ./scripts/solve.sh && ./scripts/check.sh
```

## Prerequisites

- Kubernetes cluster (Minikube from Week 8)
- `kubectl` configured
- Python 3.11+ (monitoring agent lab)

## Status

Week 17 complete — 4 observability labs, TaskFlow monitoring platform.