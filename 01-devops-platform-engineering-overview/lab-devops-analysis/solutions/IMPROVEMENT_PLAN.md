# Improvement Plan — Meridian Retail (Reference Solution)

## Executive summary

Meridian Retail's engineering teams produce software faster than operations can safely deliver it. Manual deployments, environment drift, and siloed coordination cause costly incidents and predictable release delays. This plan prioritizes **automated delivery**, **infrastructure as code**, and **observability** over 90 days, while introducing **TaskFlow** as the coordination layer for cross-team platform work. Expected outcomes: deploy weekly within 90 days (path to daily), reduce mean time to restore below 4 hours, and give leadership predictable delivery dates backed by metrics.

## Prioritized recommendations

| Priority | Initiative | DORA metric impacted | Timeline | Business value |
|----------|------------|----------------------|----------|----------------|
| P0 | Automated deploy pipeline with rollback for storefront | Time to restore, change failure rate | 30 days | Reduce revenue-impacting outage duration |
| P0 | Branch protection + required CI checks on main | Lead time, change failure rate | 14 days | Stop broken trunk; faster safe merges |
| P1 | IaC for app infrastructure (extend Terraform beyond networking) | Deployment frequency, lead time | 60 days | Eliminate ticket-driven provisioning delays |
| P1 | SLOs + team-owned alerting (replace shared inbox) | Time to restore | 45 days | Faster incident routing and diagnosis |
| P2 | TaskFlow rollout for platform initiative tracking | (Enabler) | 30 days | Visible cross-team dependencies; less spreadsheet coordination |
| P2 | Trunk-based development training + feature flags | Deployment frequency, lead time | 90 days | Shorter branches; decouple deploy from release |

## TaskFlow integration

TaskFlow becomes the **system of record for platform engineering work** — migrations to IaC, pipeline builds, SLO rollouts — with clear owners and status visible to VP Engineering. It does not replace Jira for product features but unblocks the "we can't coordinate platform work" objection from the CTO. Link TaskFlow tasks to deployment and incident metrics so leadership sees progress on DORA improvements, not just ticket volume.

## Success metrics (90-day)

- Deployment frequency: from 6-week train → **minimum weekly** deploys for one pilot team
- Lead time: pilot team **< 48 hours** from merge to production
- Change failure rate: **< 25%** for pilot team (baseline then improve)
- Time to restore: **< 4 hours** for Sev-1 incidents (measured via PagerDuty)
- TaskFlow: 100% of platform initiatives tracked with owner and weekly status

## Risks and dependencies

- **Ops capacity:** Manual ops team may resist automation — mitigate with paired workshops and quick wins (rollback script).
- **Jenkins debt:** May need parallel modern CI — start with one team, don't boil the ocean.
- **Executive patience:** Show metric movement at 30 days with pilot team dashboards.