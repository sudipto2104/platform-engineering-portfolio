# AlertManager Guide — TaskFlow Production Alerting

## Architecture

```
Prometheus (rules) → AlertManager (route) → Slack / Email / PagerDuty
```

## Routing tree

| Severity | Primary | Secondary |
|----------|---------|-------------|
| `critical` | PagerDuty | Email on-call |
| `warning` | Slack #platform-engineering | — |
| default | Slack #taskflow-alerts | — |

`continue: true` on PagerDuty route ensures email also fires for critical alerts.

## Inhibition

Critical alerts suppress matching warning alerts (same `alertname` + `namespace`) to reduce noise during incidents.

## Configure secrets

```bash
export SLACK_WEBHOOK_URL=https://hooks.slack.com/services/...
export PAGERDUTY_ROUTING_KEY=...
export SMTP_PASSWORD=...
kubectl create secret generic alertmanager-secrets -n monitoring \
  --from-literal=slack-url=$SLACK_WEBHOOK_URL
```

## Test alerts

```bash
# Trigger test alert
curl -X POST http://alertmanager:9093/api/v2/alerts -d '[{
  "labels": {"alertname": "TestAlert", "severity": "warning"},
  "annotations": {"summary": "Test from lab"}
}]'
```

## Production patterns

- `group_wait: 30s` — batch related alerts
- `repeat_interval: 4h` — don't re-notify too often
- `runbook_url` in annotations links to remediation docs
- Route by `team` label for multi-team platforms

## Verify

```bash
./scripts/check.sh
amtool check-config alertmanager/alertmanager.yml
```