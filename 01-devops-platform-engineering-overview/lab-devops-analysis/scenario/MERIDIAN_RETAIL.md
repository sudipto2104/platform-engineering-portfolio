# Case Study: Meridian Retail Group

## Company profile

**Meridian Retail Group** is a mid-size e-commerce company ($120M annual revenue, 450 employees) operating 12 regional fulfillment centers. Their engineering organization has 85 developers across 6 product teams building customer-facing storefronts, inventory systems, and internal ops tools.

Leadership has approved **TaskFlow** — a new internal task management platform — to coordinate cross-team platform work. Before adoption, they hired you to assess their DevOps maturity.

## Current state

### Development practices

- **Monolithic release train**: All teams deploy together every 6 weeks. Hotfixes require VP approval and a full regression cycle (3–5 days).
- **Manual deployments**: Ops team SSHs into servers and runs shell scripts. No automated rollback; last incident took 14 hours to restore.
- **Siloed teams**: Frontend, backend, and infrastructure teams use separate ticketing systems. Cross-team work is tracked in spreadsheets emailed between managers.
- **Environment drift**: Staging mirrors production "approximately." Config changes are applied manually and rarely documented.

### Tooling

| Layer | Tool | Notes |
|-------|------|-------|
| Version control | Git (GitHub) | Used, but trunk is often broken; long-lived feature branches (30+ days) |
| CI | Jenkins (single shared instance) | 45-minute builds; frequently queued; no required checks on PRs |
| CD | None | Manual handoff from Jenkins artifacts to ops scripts |
| IaC | Partial Terraform | Only networking team uses it; app teams still provision via tickets |
| Monitoring | Datadog (partial) | Only production has dashboards; no SLOs; alerts go to a shared email inbox |
| Incident response | PagerDuty (recent) | On-call rotation exists but runbooks are outdated |

### Recent incidents (last quarter)

1. **Checkout outage** (4 hours): A config change in staging was never promoted to a documented prod change. Ops applied a stale script.
2. **Inventory sync failure** (2 days): Database migration ran manually on one shard; data inconsistency required manual reconciliation.
3. **Failed Black Friday prep**: Deployment freeze extended 2 weeks because the release train could not absorb last-minute fixes.

### Leadership quotes

> "We move fast in development but slow in delivery. Developers are frustrated." — VP Engineering

> "I can't tell stakeholders when features will ship. Our dates slip every quarter." — Product Director

> "We need TaskFlow to coordinate platform work, but our teams can't even coordinate deployments." — CTO

## Your task

1. Identify **DevOps anti-patterns** in Meridian's current practices.
2. Assess their **DORA metrics** maturity (Low / Medium / High / Elite) with supporting evidence from the scenario.
3. Create an **improvement plan** with prioritized actions, expected DORA impact, and business value for stakeholders.
4. Explain how **TaskFlow** and platform engineering practices would address coordination gaps.

## Stakeholder audience

Your improvement plan will be presented to the CTO and VP Engineering. Lead with business outcomes (faster time-to-market, reduced incident cost, developer productivity), not tool names.