# Lab: Prometheus Metrics Collection

Install Prometheus, configure Kubernetes service discovery, deploy a custom TaskFlow metrics exporter, and write PromQL queries.

## What you build

- `prometheus.yml` with scrape configs and retention policy
- Kubernetes `ServiceMonitor` for TaskFlow pods
- Custom Python Prometheus exporter for TaskFlow API metrics
- PromQL query reference and alert rule templates

## Quick start

```bash
./scripts/solve.sh && ./scripts/check.sh
kubectl apply -f deliverables/k8s/
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
# See deliverables/PROMETHEUS_GUIDE.md for full install
```