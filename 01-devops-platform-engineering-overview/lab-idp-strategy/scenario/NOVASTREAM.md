# Case Study: NovaStream

## Company profile

**NovaStream** is a Series B video streaming startup ($45M ARR, 180 employees). Engineering has grown from **20 to 80 developers** in 18 months across 8 squads building playback, recommendations, billing, and internal tooling.

The CTO has budget for a **platform team of 6** and wants the company's first **internal developer platform (IDP)**. **TaskFlow** will track platform initiatives; your deliverable defines what those initiatives should be.

## Developer experience today

### Onboarding

- New engineers receive a 40-page Confluence doc and a `#help-infra` Slack channel.
- Local dev setup takes **3–5 days** (varies by squad); 4 different docker-compose stacks exist.
- No standard template for new services — copy-paste from the "best" squad's repo.

### Deployment

- Squads deploy to AWS via **custom GitHub Actions** copied between repos (drifted over time).
- Staging access requires a Jira ticket to ops; median wait **2 days**.
- Production deploys: 2 squads have weekly cadence, others monthly. No shared deployment observability.

### Discovery

- Engineers cannot answer: "What APIs exist?" or "Who owns this service?" without asking in Slack.
- Internal documentation is split across Notion, Confluence, and README files with no search.

### Support burden

- `#help-infra` receives **120 messages/week**. Same questions repeat (credentials, env vars, K8s namespace naming).
- Two senior ops engineers are bottlenecks for all environment provisioning.

## Business context

| Goal | Timeline | Constraint |
|------|----------|------------|
| Launch in 3 new EU markets | Q3 | Needs reliable multi-region deploy path |
| Reduce infra Slack load by 50% | 90 days | Cannot hire more ops headcount |
| Ship platform-backed self-service onboarding | 6 months | Platform team = 6 engineers |
| Adopt TaskFlow for platform work tracking | 30 days | Must show visible roadmap to board |

## Leadership asks

> "We don't need Netflix's platform overnight. What should we build first so squads stop waiting on us?" — CTO

> "Developers rate onboarding 2.8/5 in our pulse survey. Fix that without every squad inventing their own fix." — VP Engineering

> "Show me a roadmap I can defend to the board — tied to revenue milestones, not kubectl commands." — CEO

## Your task

As the platform engineering consultant:

1. **Assess developer experience gaps** and where an IDP creates leverage.
2. **Design platform capabilities** — self-service vs. curated support, golden paths, explicit non-goals.
3. **Structure the platform team** — roles, squads served, interaction model (tickets vs. paved roads).
4. **Create a platform roadmap** phased over 6 months, aligned with NovaStream's business goals and tracked in TaskFlow.