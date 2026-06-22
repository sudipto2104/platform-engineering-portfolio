# TaskFlow Backend Reading Notes (Reference)

## 1. Application startup

- **Factory:** `app/main.py` → `create_app()`
- **Dev entry:** `run.py` imports `create_app()` and runs Flask on `PORT` (default **8080**)
- **Config:** `app/config.py` — `DATABASE_URL`, `SECRET_KEY`

## 2. Routes

| File | Routes |
|------|--------|
| `app/routes/health.py` | `GET /health` |
| `app/routes/tasks.py` | `GET /api/tasks`, `POST /api/tasks` |

Blueprints registered in `create_app()` with `url_prefix="/api"` for tasks.

## 3. Models

`app/models/task.py` — SQLAlchemy `Task` with `id`, `title`, `status`, `owner`.

## 4. Service layer

`app/services/task_service.py` — `TaskService.list_tasks()` returns in-memory `TaskRead` list; `create_task()` assigns IDs.

## 5. Validation schemas

`app/schemas/task.py` — Pydantic `TaskCreate` (POST body), `TaskRead`, `TaskListResponse`.

## 6. Docker prep takeaways

- **WORKDIR** should include `app/` package and `run.py`
- **CMD** likely `gunicorn` or `python run.py`
- **ENV** `DATABASE_URL`, `PORT`, `TASKFLOW_VERSION`
- Health probe: `GET /health`