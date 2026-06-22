# Loops & Automation Patterns

| Pattern | Use in TaskFlow |
|---------|-----------------|
| `for host in "${servers[@]}"` | Rolling deploy across app servers |
| `while read` | Stream log lines for alerting |
| `until` | Wait for config file readiness |
| Nested loops | Multi-environment × service matrix |
| Arrays | Server lists, required config keys |

Run all batch tasks:

```bash
./batch_automation.sh all
```