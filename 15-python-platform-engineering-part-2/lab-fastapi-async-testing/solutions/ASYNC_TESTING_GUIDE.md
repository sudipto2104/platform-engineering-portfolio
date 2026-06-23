# Async Operations & Testing Guide — TaskFlow

## Overview

Platform engineering APIs must handle long-running operations without blocking clients. This lab adds async endpoints, FastAPI `BackgroundTasks`, and a pytest suite.

## Background tasks

`POST /api/v1/deployments` returns `202 Accepted` immediately and runs `run_deployment_job` in the background:

```python
background_tasks.add_task(run_deployment_job, job_id, service_name, environment)
```

Poll `GET /api/v1/deployments/{job_id}` for status: `queued` → `running` → `deploying` → `completed`.

## Async health checks

`GET /api/v1/deployments/health/external` uses `httpx.AsyncClient` to probe the Week 7 TaskFlow API asynchronously.

## Run the API

```bash
cd deliverables
pip install -r requirements.txt
uvicorn taskflow_platform_api.main:app --reload
```

## Run tests

```bash
cd deliverables
pytest tests/ -v
# or from lab root:
pytest deliverables/taskflow_platform_api/tests/ -c deliverables/pytest.ini
```

## Test patterns

| Pattern | Usage |
|---------|-------|
| `TestClient` | Synchronous test client for FastAPI |
| `conftest.py` | Shared `client` fixture |
| Polling | Wait for background task completion |
| Status codes | Assert 202 for async accept, 404 for missing jobs |

## Production extensions

- Replace in-memory `JOBS` dict with Redis or database
- Use Celery/ARQ for distributed background workers
- Add WebSocket endpoint for live deployment progress (Week 17 preview)

## Verify

```bash
./scripts/check.sh
pytest taskflow_platform_api/tests/ -v
```