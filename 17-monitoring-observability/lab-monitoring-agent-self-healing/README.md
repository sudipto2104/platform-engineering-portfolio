# Lab: Monitoring Agent with Self-Healing

Build a production-grade monitoring agent that collects Prometheus-compatible metrics, evaluates thresholds, and executes automated remediation workflows.

## What you build

- `taskflow_monitor_agent/` — metrics collector + alert evaluator
- Automated remediation: pod restart, deployment scale, incident logging
- Kubernetes Deployment manifest for the agent

## Quick start

```bash
./scripts/solve.sh && ./scripts/check.sh
pip install -r deliverables/requirements.txt
python -m taskflow_monitor_agent --dry-run
kubectl apply -f deliverables/k8s/
```