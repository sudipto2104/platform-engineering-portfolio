# Project: TaskFlow Documentation

Create production-quality documentation that makes **TaskFlow** accessible to developers, contributors, and portfolio reviewers.

## Deliverables

| File | Audience | Purpose |
|------|----------|---------|
| `README.md` | Everyone | Setup, run, deploy, verify |
| `CONTRIBUTING.md` | Contributors | How to propose changes |
| `docs/ARCHITECTURE.md` | Engineers | System design overview |
| `docs/API.md` | API consumers | Endpoints, schemas, examples |

Work in `deliverables/` first. When ready, copy into [`../taskflow/`](../taskflow/) to publish.

Templates: `templates/`. Reference: `examples/`.

## Verify

```bash
./scripts/check.sh
```

## Solution

```bash
./scripts/solve.sh
```

Generates reference docs in `deliverables/` and publishes them to `../taskflow/`.