# TaskFlow Risk Register (Reference)

| ID | Risk | Category | Likelihood | Impact | Mitigation | Owner |
|----|------|----------|------------|--------|------------|-------|
| R1 | Bootcamp pace exceeds available hours | Schedule | High | High | MVP scope freeze at Week 10; defer nice-to-haves | Student |
| R2 | Cloud costs exceed budget | Financial | Medium | Medium | Tear-down scripts; local K8s default | Platform |
| R3 | Scope creep (build full Jira clone) | Product | High | High | MVP_DEFINITION non-goals enforced | Student |
| R4 | Docker/K8s environment drift on laptop | Technical | Medium | High | Dev container + documented prerequisites | DX |
| R5 | Terraform state loss | Technical | Low | High | Remote state Week 11; backups | Infra |
| R6 | Secrets committed to git | Security | Medium | Critical | Pre-commit hooks Week 3; scan Week 18 | Security |
| R7 | Incomplete docs hurt portfolio | Adoption | Medium | High | project-taskflow-documentation checks in CI | Student |
| R8 | Single-developer bus factor | People | High | Medium | CONTRIBUTING.md; architecture docs | Student |
| R9 | Upstream bootcamp curriculum changes | External | Low | Medium | Pin sprint plan; document deltas | Student |
| R10 | Observability tooling complexity | Technical | Medium | Medium | Start with logs + health; add metrics Week 17 | SRE |

## Top 3 risks (executive view)

1. **Schedule overload (R1)** — mitigate with ruthless MVP scope.
2. **Scope creep (R3)** — TaskFlow is a learning vehicle, not a startup product.
3. **Secrets in repo (R6)** — automate detection early.

## Review cadence

- End of each sprint: update likelihood/impact
- MVP checkpoint (Week 10): full register review
- Week 21: close or accept residual risks for portfolio narrative