# Week 15: Python for Platform Engineering — Part 2

**Slug:** `python-platform-engineering-part-2`

Build production-ready FastAPI platform automation APIs for TaskFlow — RESTful infrastructure management, JWT authentication with RBAC, and async background tasks with pytest.

Builds on [`../14-python-platform-engineering-part-1/`](../14-python-platform-engineering-part-1/) (Python automation), [`../07-introduction-containers-docker/taskflow-stack/`](../07-introduction-containers-docker/taskflow-stack/) (TaskFlow backend), and [`../13-internal-developer-portals/`](../13-internal-developer-portals/) (platform portal).

## Labs

| Directory | Focus |
|-----------|--------|
| [`lab-fastapi-platform-api/`](./lab-fastapi-platform-api/) | FastAPI CRUD, SQLAlchemy, Pydantic, OpenAPI/Swagger |
| [`lab-fastapi-jwt-rbac/`](./lab-fastapi-jwt-rbac/) | JWT authentication and role-based access control |
| [`lab-fastapi-async-testing/`](./lab-fastapi-async-testing/) | Async operations, background tasks, pytest suite |

Each lab includes `scripts/check.sh` and `scripts/solve.sh`.

## Quick start

```bash
cd lab-fastapi-platform-api && ./scripts/solve.sh && ./scripts/check.sh
cd ../lab-fastapi-jwt-rbac && ./scripts/solve.sh && ./scripts/check.sh
cd ../lab-fastapi-async-testing && ./scripts/solve.sh && ./scripts/check.sh
```

## Prerequisites

- Python 3.11+
- `pip install -r deliverables/requirements.txt` per lab

## Status

Week 15 complete — 3 FastAPI platform engineering labs, TaskFlow automation API.