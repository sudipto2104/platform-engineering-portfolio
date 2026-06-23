# Lab: Backstage Service Catalog

Install Backstage, understand its architecture, and register every TaskFlow microservice in the software catalog with proper metadata, relationships, and GitHub integrations.

Compare React patterns (JSX, hooks, `useState`, `useEffect`) to the Vue.js Composition API you used in Week 6.

## What you build

- Backstage `app-config.yaml` with catalog locations and GitHub integration
- Domain, System, Component, API, and Resource entities for TaskFlow
- Catalog relationships: frontend → backend → postgres/redis
- React vs Vue comparison guide tied to TaskFlow code

## Quick start

```bash
./scripts/solve.sh && ./scripts/check.sh
```

After solve, read `deliverables/BACKSTAGE_CATALOG_GUIDE.md` and `deliverables/REACT_VS_VUE.md`.

### Run Backstage locally (optional)

```bash
cd deliverables/workspace
npx @backstage/create-app@latest --skip-install  # first-time scaffold
yarn install && yarn dev
```

Catalog entities in `deliverables/catalog/` are loaded via `app-config.yaml`.