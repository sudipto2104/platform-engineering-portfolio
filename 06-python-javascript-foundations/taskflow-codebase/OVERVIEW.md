# TaskFlow Codebase Overview (Week 6)

Week 6 introduces the **full-stack TaskFlow layout** you will containerize in Week 7.

## Backend (`taskflow-api`)

| Path | Purpose |
|------|---------|
| `app/main.py` | Application factory and startup |
| `app/routes/` | HTTP route handlers |
| `app/models/` | Database models (SQLAlchemy) |
| `app/services/` | Business logic layer |
| `app/schemas/` | Request/response validation (Pydantic) |

## Frontend (`taskflow-ui`)

| Path | Purpose |
|------|---------|
| `src/main.js` | Vue app bootstrap |
| `src/App.vue` | Root layout |
| `src/components/` | Reusable UI components |
| `src/views/` | Route-level pages |
| `src/stores/` | Pinia state management |
| `src/router/` | Vue Router configuration |
| `src/api/` | HTTP client for backend API |

Read both codebases with `tree`, `grep`, and `less` before writing Dockerfiles.