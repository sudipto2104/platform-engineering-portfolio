# DORA Metrics Assessment — Meridian Retail (Reference Solution)

## Deployment frequency

- **Rating:** Low
- **Evidence:** Production deployments occur on a 6-week release train, not on demand. Hotfixes are exceptional events requiring executive approval.
- **Improvement lever:** Implement per-team deployment pipelines with automated promotion; target weekly → daily cadence in phases.

## Lead time for changes

- **Rating:** Low
- **Evidence:** Hotfix cycle is 3–5 days; features wait for release train; manual ops handoff adds delay after CI completes.
- **Improvement lever:** End-to-end automation from merge to production; eliminate manual SSH deployments; reduce CI queue time.

## Change failure rate

- **Rating:** Medium–High (worse than elite)
- **Evidence:** Three significant incidents last quarter including checkout outage and 2-day inventory failure; config and migration errors in production.
- **Improvement lever:** Automated testing gates, canary deployments, IaC-reviewed infrastructure changes, migration automation.

## Time to restore service

- **Rating:** Low
- **Evidence:** Checkout outage: 4 hours; historical incident: 14 hours; outdated runbooks despite new PagerDuty rotation.
- **Improvement lever:** Automated rollback, current runbooks, practice game days, SLO-driven paging to owning teams.

## Overall maturity summary

Meridian Retail operates at **low maturity** across most DORA metrics, typical of organizations with manual operations and infrequent releases. The gap between development velocity and delivery capability is the primary business risk — directly impacting revenue events (Black Friday) and customer trust. A phased platform engineering investment (CI/CD, IaC, observability, TaskFlow coordination) can move two metrics within 90 days: deployment frequency and time to restore.