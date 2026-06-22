# TaskFlow Vue 3 Reading Notes (Reference)

## 1. App bootstrap

`src/main.js` — `createApp(App)`, registers **Pinia** and **Vue Router**, mounts `#app`.

## 2. Components

| Component | Role |
|-----------|------|
| `App.vue` | Root shell with `<RouterView />` |
| `AppHeader.vue` | Nav links to Dashboard / Tasks |
| `TaskList.vue` | Fetches and renders task collection |
| `TaskCard.vue` | Single task card; `statusClass` from `task.status` |

## 3. Pinia store

`src/stores/taskStore.js` — `useTaskStore()` with `fetchTasks()` action calling `api/taskflow.js`.

## 4. Router

`src/router/index.js` — routes `/` → `DashboardView`, `/tasks` → `TasksView`.

## 5. API client

`src/api/taskflow.js` — Axios client; `baseURL` from `VITE_API_URL` or `/api` (Vite proxy to `:8080`).

## 6. Views

- `DashboardView.vue` — summary + health probe
- `TasksView.vue` — embeds `TaskList`

## Docker prep takeaways

- **Build:** `npm run build` → `dist/`
- **Dev server port:** 3000 (vite.config.js)
- **Env:** `VITE_API_URL` for production API host
- **Static serve:** nginx or similar for `dist/` in container