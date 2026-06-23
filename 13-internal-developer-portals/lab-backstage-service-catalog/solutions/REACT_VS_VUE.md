# React vs Vue — TaskFlow Comparison

Backstage plugins are built with **React + TypeScript**. TaskFlow's frontend (Week 6) uses **Vue 3 Composition API**. This guide maps equivalent patterns using real TaskFlow code.

## Architecture overview

| Concern | Vue (TaskFlow Week 6) | React (Backstage plugins) |
|---------|----------------------|---------------------------|
| UI syntax | Single-file `.vue` templates | JSX in `.tsx` files |
| State | `ref()`, `reactive()`, Pinia stores | `useState`, `useReducer`, context |
| Side effects | `onMounted`, `watch`, `watchEffect` | `useEffect` |
| Data fetching | `async` in `onMounted` or store actions | `useEffect` + `fetch` / `useAsync` |
| Styling | Scoped CSS in SFC | Material-UI `makeStyles` / `sx` prop |

## Reactive state

**Vue (Pinia store — Week 6):**

```javascript
export const useTaskStore = defineStore('tasks', {
  state: () => ({ tasks: [], loading: false, error: null }),
  actions: {
    async fetchTasks() {
      this.loading = true
      const data = await fetchTasks()
      this.tasks = data.tasks
      this.loading = false
    },
  },
})
```

**React equivalent (Backstage plugin):**

```tsx
const [tasks, setTasks] = useState<Task[]>([]);
const [loading, setLoading] = useState(false);
const [error, setError] = useState<string | null>(null);

useEffect(() => {
  setLoading(true);
  fetchTasks()
    .then(data => setTasks(data.tasks))
    .catch(err => setError(err.message))
    .finally(() => setLoading(false));
}, []);
```

## Lifecycle / mounting

**Vue (`DashboardView.vue`):**

```vue
<script setup>
import { ref, onMounted } from 'vue'

const health = ref('unknown')

onMounted(async () => {
  const data = await fetchHealth()
  health.value = data.status
})
</script>
```

**React:**

```tsx
const [health, setHealth] = useState('unknown');

useEffect(() => {
  fetchHealth()
    .then(data => setHealth(data.status))
    .catch(() => setHealth('offline'));
}, []);
```

## Template vs JSX

**Vue template:**

```vue
<ul>
  <li>Total tasks: {{ store.tasks.length }}</li>
  <li>API status: {{ health }}</li>
</ul>
```

**React JSX:**

```tsx
<ul>
  <li>Total tasks: {tasks.length}</li>
  <li>API status: {health}</li>
</ul>
```

## Key takeaways for Backstage development

1. **Hooks replace Composition API** — `useState` ≈ `ref`, `useEffect` ≈ `onMounted`/`watch`.
2. **No two-way `v-model`** — React uses controlled components with `value` + `onChange`.
3. **Material-UI replaces custom CSS** — Backstage ships with MUI; use `Grid`, `Card`, `Typography`.
4. **Plugins are packages** — Each Backstage plugin is a Yarn workspace package with its own `src/` tree.

See `lab-backstage-taskflow-dashboard-plugin/` for a complete React plugin implementing the TaskFlow dashboard.