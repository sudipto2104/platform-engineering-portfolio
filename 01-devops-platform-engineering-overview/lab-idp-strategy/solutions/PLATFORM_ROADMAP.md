# Platform Roadmap — NovaStream (Reference)

## Roadmap principles

1. **Reduce waiting** before reducing cost — staging self-service first.
2. **One golden path** done well beats five partial templates.
3. Every initiative ties to **EU expansion**, **Slack reduction**, or **onboarding score**.
4. Progress visible in **TaskFlow** for board reporting.

## Phase 1 — Foundation (0–30 days)

| Initiative | Capability | Owner | TaskFlow link | Business outcome |
|------------|------------|-------|---------------|------------------|
| TaskFlow rollout | Coordination | Platform lead | EPIC-001 | Board-visible platform tracker |
| Python API template v1 | Scaffolding | Golden path | EPIC-002 | Onboarding baseline |
| Shared CI module | CI/CD | Golden path | EPIC-003 | Stop Actions drift |

## Phase 2 — Self-service (30–90 days)

| Initiative | Capability | Owner | TaskFlow link | Business outcome |
|------------|------------|-------|---------------|------------------|
| Staging namespace API | Ephemeral envs | Infra | EPIC-004 | Eliminate 2-day Jira wait |
| Service catalog MVP | Discovery | DX engineer | EPIC-005 | Reduce "who owns this?" Slack |
| Secrets injection pattern | Config | Infra | EPIC-006 | Cut #help-infra volume 25% |

## Phase 3 — Scale (90–180 days)

| Initiative | Capability | Owner | TaskFlow link | Business outcome |
|------------|------------|-------|---------------|------------------|
| Guided prod promotion | Multi-region deploy | Infra + ops | EPIC-007 | EU market readiness |
| Observability baseline per service | SLOs | DX + infra | EPIC-008 | Faster incident response |
| Second golden path (Node API) | Scaffolding | Golden path | EPIC-009 | Remaining squads onboarded |

## Dependencies and risks

- **Risk:** Squads ignore template if missing features — mitigate with liaison feedback loop.
- **Dependency:** AWS account structure must support per-squad namespaces before Phase 2.
- **Risk:** Backstage scope creep — ship thin catalog first.

## Board-ready one-liner

"NovaStream's platform team will cut developer onboarding from five days to one and staging access from two days to minutes — unlocking EU expansion without adding ops headcount."