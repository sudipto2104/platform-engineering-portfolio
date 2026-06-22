# Developer Experience Assessment — NovaStream (Reference)

## Current state summary

NovaStream's engineering velocity is constrained by **invisible platform debt**: every squad reinvents onboarding, CI/CD, and environment access. Developers spend days unblocking infra instead of shipping features — directly threatening EU expansion timelines. The 2.8/5 onboarding score and 120 weekly `#help-infra` messages are symptoms of missing golden paths, not lazy developers.

## Pain points (ranked)

| Rank | Pain point | Evidence | Affected squads | Severity (1–5) |
|------|------------|----------|-----------------|----------------|
| 1 | No paved path to staging | 2-day Jira wait for staging access | All 8 | 5 |
| 2 | Fragmented onboarding | 3–5 day setup; 4 docker-compose variants | New hires | 5 |
| 3 | Undiscoverable services | "Who owns this?" only answered in Slack | All | 4 |
| 4 | Drifted CI/CD templates | Copied GitHub Actions diverged per squad | 6 squads | 4 |
| 5 | Ops bottleneck | 2 engineers provision all environments | All | 5 |

## Golden path gaps

**Today:** Each squad improvises deploy pipelines, local stacks, and service discovery.

**Should exist:** A single "NovaStream Service Template" — clone → configure → deploy to shared staging in < 4 hours, with documented APIs and owners in a catalog.

## Platform opportunities

| Opportunity | Business outcome |
|-------------|------------------|
| Self-service staging namespaces | Removes 2-day wait; unblocks EU feature teams |
| Service template + docs portal | Cuts onboarding from 5 days → 1 day; improves pulse score |
| Standardized deploy pipeline module | Predictable weekly deploys for all squads before EU launch |
| TaskFlow for platform initiatives | Board-visible roadmap; replaces ad-hoc Slack commitments |

## Metrics to baseline

| DX metric | Current estimate | Target (90 days) |
|-----------|------------------|------------------|
| Time to first PR | 3–5 days | < 1 day |
| #help-infra volume | 120/week | < 60/week |
| Onboarding satisfaction | 2.8/5 | ≥ 4.0/5 |