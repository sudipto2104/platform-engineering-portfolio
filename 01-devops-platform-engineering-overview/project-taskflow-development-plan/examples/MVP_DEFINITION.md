# TaskFlow MVP Definition (Reference)

## MVP statement

**TaskFlow MVP** (end of **Sprint 5 / Week 10**): A containerized task API deployed to a cloud environment via IaC, with CI verification, basic auth stub, and documentation sufficient for a new engineer to contribute in one day.

## In scope (MVP)

| Capability | Done criteria |
|------------|---------------|
| Task CRUD API | `GET/POST /api/tasks` with persistence |
| Health & version | `/health` used in deploy gate |
| Container image | Reproducible Docker build in CI |
| IaC deploy | Terraform module applies to cloud target |
| CI pipeline | Lint, test, build on every PR |
| Docs | README, API, architecture, contributing |
| Platform automation | Setup, health, smoke scripts |

## Out of scope (post-MVP)

- Full IDP portal / Backstage plugins (Weeks 13–20)
- Multi-tenant SaaS billing
- Advanced auth (SSO) — Week 18 secrets
- Service mesh (Week 19)
- Production hardening certification (Week 21)

## MVP users

- Bootcamp engineers (primary)
- Portfolio reviewers (secondary)
- Internal platform team (coordination use case)

## MVP success metrics

| Metric | Target |
|--------|--------|
| New engineer: first PR | < 1 day |
| Deploy from merge | < 30 minutes (staging) |
| API uptime (staging) | 99% during bootcamp weeks |
| Documentation completeness | All check scripts pass |

## TaskFlow bootcamp tasks at MVP

Sample tasks tracked in the app:

1. Containerize TaskFlow — **done** (Week 1)
2. Cloud IaC module — **in progress** (Weeks 10–11)
3. Persist tasks to database — **todo** (Week 6)
4. CI pipeline green — **todo** (Week 3–5)