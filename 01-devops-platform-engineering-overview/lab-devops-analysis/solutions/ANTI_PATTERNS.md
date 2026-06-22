# DevOps Anti-Patterns — Meridian Retail (Reference Solution)

## 1. Release train / big-bang deployments

- **Evidence:** 6-week release train; hotfixes need VP approval; Black Friday freeze extended 2 weeks.
- **Impact:** Long lead times, inability to respond to market events, developer frustration when work sits undeployed.
- **Recommended direction:** Move toward continuous delivery with trunk-based development and automated promotion pipelines.

## 2. Manual deployment without rollback

- **Evidence:** Ops SSHs into servers; checkout outage took 4 hours; no automated rollback documented.
- **Impact:** High change failure recovery time; human error in config promotion (stale script incident).
- **Recommended direction:** Immutable deployments via containers, automated rollback, and deployment records in IaC.

## 3. Siloed ownership and ticket-driven ops

- **Evidence:** Separate ticketing systems; cross-team work in spreadsheets; app teams provision via tickets while only networking uses Terraform.
- **Impact:** Slow cross-team coordination; invisible dependencies; platform work competes with feature work informally.
- **Recommended direction:** Internal developer platform with self-service paths; TaskFlow for cross-team task visibility.

## 4. Environment drift

- **Evidence:** Staging "approximately" mirrors prod; manual undocumented config changes.
- **Impact:** Works-in-staging-fails-in-prod failures; unpredictable releases; long regression cycles.
- **Recommended direction:** Environment parity through IaC and GitOps; config as code with reviewed changes.

## 5. Weak CI governance

- **Evidence:** 45-minute Jenkins builds; no required PR checks; frequently queued; trunk often broken.
- **Impact:** Low confidence in merges; long feedback loops; defects discovered late.
- **Recommended direction:** Required status checks, faster parallel CI, branch protection on main.

## 6. Observability gaps

- **Evidence:** Partial Datadog coverage; no SLOs; alerts to shared inbox; 14-hour restore in past incident.
- **Impact:** Slow incident detection and diagnosis; unclear ownership during outages.
- **Recommended direction:** SLO-based alerting, runbooks linked to services, incident metrics tracked as DORA "time to restore."

## 7. Long-lived feature branches

- **Evidence:** Branches live 30+ days; broken trunk normalized.
- **Impact:** Painful merges, integration defects, delayed value delivery.
- **Recommended direction:** Short-lived branches, feature flags, daily integration to main.