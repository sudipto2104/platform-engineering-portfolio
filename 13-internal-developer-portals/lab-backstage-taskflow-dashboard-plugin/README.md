# Lab: TaskFlow Dashboard Plugin

Build a custom Backstage plugin in React + TypeScript that displays live TaskFlow metrics — task counts, active users, and deployment status.

## What you build

- Backstage frontend plugin scaffolded with `@backstage/cli`
- `TaskFlowDashboardPage` with `useState` and `useEffect` hooks
- Material-UI cards and grid layout
- API client with loading and error states
- Navigation integration via `createPlugin` and routes

## Quick start

```bash
./scripts/solve.sh && ./scripts/check.sh
```

Copy `deliverables/plugins/taskflow-dashboard/` into your Backstage app's `plugins/` directory and register in `packages/app/src/App.tsx`.

### Scaffold in a live Backstage app

```bash
cd your-backstage-app
yarn new --select plugin
# Name: taskflow-dashboard
# Then merge deliverables/plugins/taskflow-dashboard/src/ into the scaffold
```