# Platform Capabilities — NovaStream IDP (Reference)

## Capability map

| Capability | User need | Self-service level | Build vs. buy | Phase |
|------------|-----------|-------------------|---------------|-------|
| Service scaffolding | Start new service fast | Guided | Build (template) | 1 |
| CI/CD pipeline module | Deploy without copying YAML | Full | Build (shared Actions) | 1 |
| Ephemeral staging environments | Test without Jira ticket | Full | Build on AWS | 2 |
| Service catalog | Find APIs and owners | Guided | Buy (Backstage) or build thin | 2 |
| Secrets & config injection | Stop env var Slack threads | Guided | Build + AWS SM | 2 |
| Observability baseline | Dashboards per service | Full | Buy (Datadog existing) | 3 |
| Multi-region deploy path | EU market launch | Ticket → Guided | Build | 3 |

## Golden paths (MVP)

**"Python API to staging"** — the first paved road:

1. `nova scaffold python-api <name>` from approved template
2. PR triggers standard CI (lint, test, container build)
3. Merge to main auto-deploys to squad staging namespace
4. Service registered in catalog with owner and `/health` SLO

TaskFlow tracks template, pipeline module, and namespace provisioning as linked initiatives.

## Explicit non-goals (6 months)

- Full multi-cloud abstraction
- Custom service mesh
- Replacing squad-level product Jira
- 100% self-service production deploys (guided promotion only in Phase 3)

## TaskFlow integration

Each capability maps to a TaskFlow epic with owner, phase, and done criteria (e.g., "staging namespace: 8/8 squads used self-service at least once").