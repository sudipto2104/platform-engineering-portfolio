# Self-Healing Monitoring Agent Guide — TaskFlow

## Overview

The TaskFlow monitoring agent combines Prometheus-compatible metrics collection, threshold-based alerting, and automated remediation — intelligent self-healing for platform engineering.

## Architecture

```
┌─────────────────┐     ┌──────────────┐     ┌─────────────────┐
│ Health checks   │────▶│  Thresholds  │────▶│  Remediation    │
│ (metrics.py)    │     │ (thresholds) │     │ (remediation.py)│
└────────┬────────┘     └──────────────┘     └────────┬────────┘
         │                                            │
         ▼                                            ▼
   :9101/metrics                              kubectl restart/scale
         │                                            │
         └──────────────▶ Prometheus ◀─────────────────┘
                              │
                              ▼
                        AlertManager → Slack/PagerDuty
```

## Threshold rules

| Alert | Condition | Remediation |
|-------|-----------|-------------|
| `api_down` | healthy == 0 | `kubectl rollout restart` |
| `high_latency` | latency > 1s | Scale to 3 replicas |
| `error_streak` | 3+ consecutive failures | Restart deployment |

## Run locally

```bash
pip install -r requirements.txt
python -m taskflow_monitor_agent --dry-run --interval 10
curl localhost:9101/metrics
```

## Deploy to Kubernetes

```bash
kubectl apply -f k8s/agent-deployment.yaml
kubectl logs -n taskflow -l app=taskflow-monitor-agent -f
```

## Incident response automation

All remediations are logged to `/tmp/taskflow-incidents.jsonl` with timestamp, alert name, action, and result. Integrate with Week 15 FastAPI platform API for incident dashboards.

## Integration with AlertManager

Agent metrics (`taskflow_agent_remediations_total`) can trigger AlertManager rules when remediations fail — human escalation path.

## Verify

```bash
./scripts/check.sh
python -m taskflow_monitor_agent --dry-run
```