# PromQL Queries — TaskFlow

## Availability

```promql
# Is the exporter up?
up{job="taskflow-exporter"}

# API health gauge
taskflow_api_healthy
```

## Request rate

```promql
# Total request rate (req/sec)
rate(taskflow_http_requests_total[5m])

# Error rate percentage
rate(taskflow_http_requests_total{status=~"5.."}[5m])
  / rate(taskflow_http_requests_total[5m]) * 100
```

## Latency

```promql
# p50 latency
histogram_quantile(0.50,
  rate(taskflow_http_request_duration_seconds_bucket[5m]))

# p95 latency
histogram_quantile(0.95,
  rate(taskflow_http_request_duration_seconds_bucket[5m]))

# p99 latency
histogram_quantile(0.99,
  rate(taskflow_http_request_duration_seconds_bucket[5m]))
```

## Business metrics

```promql
# Current task count
taskflow_tasks_total

# Active users estimate
taskflow_active_users
```

## Kubernetes pod monitoring

```promql
# Pods not ready in taskflow namespace
kube_pod_status_ready{namespace=~"taskflow.*", condition="false"} == 1

# Container restarts
rate(kube_pod_container_status_restarts_total{namespace="taskflow"}[1h])
```

## Alerting examples

```promql
# Sustained high error rate
rate(taskflow_http_requests_total{status=~"5.."}[5m])
  / rate(taskflow_http_requests_total[5m]) > 0.05

# API down for 2 minutes
up{job="taskflow-exporter"} == 0
```