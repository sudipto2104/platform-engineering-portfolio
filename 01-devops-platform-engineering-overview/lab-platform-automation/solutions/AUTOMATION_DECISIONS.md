# Automation Decisions — TaskFlow (Reference)

## Principles applied

1. **Idempotence** — safe to re-run (`taskflow-setup.sh` skips existing venv).
2. **Structured logging** — ISO timestamps to `/tmp/taskflow-automation/*.log`.
3. **Exit codes** — `0` success, `1` runtime failure, `2` misconfiguration (`taskflow-health.sh`).
4. **Fail fast** — `set -euo pipefail` on all scripts.
5. **Graceful optional paths** — smoke test skips replicas that are not running.

## Decision log

| ID | Decision | Rationale |
|----|----------|-----------|
| D1 | Automate onboarding deps | Highest toil × frequency; low risk |
| D2 | Do not auto-start server in setup | Starting servers belongs in runbooks/CI, not setup |
| D3 | Health script is read-only | Safe for cron and pre-demo checks |
| D4 | Smoke script tolerates missing replicas | Idempotent lab runs may only have :8080 |
| D5 | Defer full dependency audit | Needs SBOM tooling (later bootcamp weeks) |

## When we chose not to automate

- **Subjective demo narration** — automation verifies facts, not storytelling.
- **One-off debugging** — `$SHELL` exploration stays manual.
- **Policy exceptions** — e.g., skipping security scan requires human approval.

## Integration with TaskFlow roadmap

These scripts become the seed of TaskFlow's **platform golden path** in Week 5 (shell scripting) and later CI checks in GitHub Actions.