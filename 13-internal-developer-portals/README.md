# Week 13: Backstage Internal Developer Portal

**Slug:** `backstage-developer-portal`

Set up [Backstage](https://backstage.io/) as TaskFlow's internal developer portal. Learn React fundamentals by comparing patterns to the Vue.js frontend from Week 6, register the full TaskFlow service catalog, build a custom metrics plugin, and ship self-service software templates.

Builds on [`../07-introduction-containers-docker/taskflow-stack/`](../07-introduction-containers-docker/taskflow-stack/) (TaskFlow stack), [`../08-kubernetes-fundamentals/`](../08-kubernetes-fundamentals/) (K8s manifests), and [`../06-python-javascript-foundations/`](../06-python-javascript-foundations/) (Vue frontend).

## Labs

| Directory | Focus |
|-----------|--------|
| [`lab-backstage-service-catalog/`](./lab-backstage-service-catalog/) | Install Backstage, architecture, React vs Vue, TaskFlow catalog entities |
| [`lab-backstage-taskflow-dashboard-plugin/`](./lab-backstage-taskflow-dashboard-plugin/) | Custom React plugin — TaskFlow metrics dashboard with hooks & Material-UI |
| [`lab-backstage-software-templates/`](./lab-backstage-software-templates/) | Software templates, GitHub/K8s/monitoring integrations, FastAPI scaffold |

Each lab includes `scripts/check.sh` and `scripts/solve.sh`.

## Quick start

```bash
cd lab-backstage-service-catalog && ./scripts/solve.sh && ./scripts/check.sh
cd ../lab-backstage-taskflow-dashboard-plugin && ./scripts/solve.sh && ./scripts/check.sh
cd ../lab-backstage-software-templates && ./scripts/solve.sh && ./scripts/check.sh
```

## Prerequisites

- Node.js 20+ and Yarn 4 (for running Backstage locally)
- Docker (TaskFlow stack from Week 7)
- GitHub account (`sudipto2104`) for catalog links and template publishing

## Status

Week 13 complete — 3 Backstage labs, TaskFlow IDP foundation.