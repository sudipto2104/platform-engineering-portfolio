# Prometheus Guide — TaskFlow Monitoring

## Install (kube-prometheus-stack)

```bash
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm install prometheus prometheus-community/kube-prometheus-stack \
  -n monitoring --create-namespace
kubectl apply -f deliverables/k8s/servicemonitor-taskflow.yaml
```

## Custom exporter

```bash
pip install -r requirements.txt
TASKFLOW_API_URL=http://localhost:8080 python exporters/taskflow_exporter.py
curl localhost:9100/metrics
```

## Key configuration

| Setting | Value | Purpose |
|---------|-------|---------|
| `scrape_interval` | 15s | How often to collect metrics |
| `retention.time` | 15d | TSDB retention |
| `retention.size` | 10GB | Max disk usage |
| `kubernetes_sd_configs` | pod + service | Auto-discover TaskFlow pods |

## Service discovery

Pods annotated with `prometheus.io/scrape: "true"` are auto-discovered. The `ServiceMonitor` CRD (Prometheus Operator) targets TaskFlow API services.

## Verify

```bash
./scripts/check.sh
kubectl port-forward -n monitoring svc/prometheus-kube-prometheus-prometheus 9090:9090
# Query: up{job="taskflow-exporter"}
```