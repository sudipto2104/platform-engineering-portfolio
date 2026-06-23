# TaskFlow Dashboard Plugin Guide

## Scaffold the plugin

```bash
cd taskflow-portal
yarn new --select plugin
# Plugin name: taskflow-dashboard
```

Replace the generated `src/` with files from `deliverables/plugins/taskflow-dashboard/src/`.

## Register in the app

1. Add workspace dependency in `packages/app/package.json`:
   ```json
   "@internal/plugin-taskflow-dashboard": "workspace:*"
   ```
2. Copy `app-integration-snippet.tsx` patterns into `packages/app/src/App.tsx`.
3. Add proxy in `app-config.yaml` (from Lab 1):
   ```yaml
   proxy:
     endpoints:
       '/taskflow-api':
         target: http://localhost:8080
   ```

## React patterns used

| Pattern | Where | Vue equivalent (Week 6) |
|---------|-------|-------------------------|
| `useState` | `TaskFlowDashboardPage` | `ref()` |
| `useEffect` | Data fetch + 30s refresh | `onMounted` + `setInterval` |
| JSX | Metric cards, grid | `<template>` |
| Material-UI | `Grid`, `Card`, `Typography` | Custom scoped CSS |

## Run and verify

```bash
# Terminal 1 — TaskFlow API (Week 7 stack)
cd 07-introduction-containers-docker/taskflow-stack
docker compose up

# Terminal 2 — Backstage
cd taskflow-portal && yarn dev
```

Open `http://localhost:3000/taskflow-dashboard` — you should see task count, active users, and deployment status.

```bash
./scripts/check.sh
```