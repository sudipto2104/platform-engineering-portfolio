# Platform Team Structure — NovaStream (Reference)

## Recommended model

**Centralized platform team with paved-road product ownership** — 6 engineers is too small to embed in every squad, but too large to be a ticket-taking ops extension. The team owns **golden paths** and **self-service APIs**; squads own application code on those paths.

## Team topology

| Role | Count | Responsibility | Serves |
|------|-------|----------------|--------|
| Platform lead / TPM | 1 | Roadmap, stakeholder alignment, TaskFlow governance | CTO, VPE |
| Golden path engineer | 2 | Templates, CI modules, scaffolding CLI | All squads |
| Infrastructure engineer | 2 | AWS staging, namespaces, IaC modules | All squads |
| Developer experience engineer | 1 | Docs portal, catalog, onboarding guides | New hires + all squads |

## Interaction model

- **Self-service first:** Docs + automation for capabilities marked "Full" in the capability map.
- **Office hours:** 2× weekly for "Guided" capabilities; questions logged to improve docs.
- **Escalations:** Only for net-new infra patterns not on the roadmap — requires TaskFlow intake with VPE approval.
- **SLA:** `#help-infra` responses triaged within 4 hours; repeated questions trigger a paved-road task.

## Interfaces with existing ops

The 2 senior ops engineers transition from **doers** to **reviewers** for production changes and incident command. Platform team owns pre-production self-service; ops retains production safety gates until Phase 3 guided promotion matures.

## Success criteria for team design

- Platform team spends **< 30%** of time on ad-hoc tickets by day 90
- Each squad has a named **platform liaison** (rotating, 1-hour/week) for feedback
- TaskFlow shows 100% of platform work; zero parallel spreadsheet roadmaps