# Lab: AlertManager Routing

Configure AlertManager with alert rules, notification channels, severity-based routing, and inhibition policies.

## What you build

- `alertmanager.yml` with Slack, email, and PagerDuty receivers
- Production alert rules with severity labels
- Route tree: critical → PagerDuty, warning → Slack

## Quick start

```bash
./scripts/solve.sh && ./scripts/check.sh
kubectl apply -f deliverables/alertmanager/
```