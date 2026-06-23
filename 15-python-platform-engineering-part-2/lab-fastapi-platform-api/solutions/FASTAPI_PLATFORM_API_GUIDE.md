# FastAPI Platform API Guide — TaskFlow

## Overview

Production-ready RESTful API for managing TaskFlow platform resources. Evolves the Week 7 task API into full infrastructure management with SQLAlchemy persistence and OpenAPI documentation.

## Stack

| Technology | Role |
|------------|------|
| FastAPI | High-performance async-capable web framework |
| SQLAlchemy 2.0 | ORM for platform_services and platform_environments |
| Pydantic v2 | Request/response validation |
| Uvicorn | ASGI server |

## RESTful design

| Method | Endpoint | Action |
|--------|----------|--------|
| GET | `/api/v1/services` | List services |
| POST | `/api/v1/services` | Create service |
| GET | `/api/v1/services/{id}` | Get service |
| PUT | `/api/v1/services/{id}` | Update service |
| DELETE | `/api/v1/services/{id}` | Delete service |
| GET | `/api/v1/environments` | List environments |
| POST | `/api/v1/environments` | Create environment |

## Run locally

```bash
cd deliverables
pip install -r requirements.txt
uvicorn taskflow_platform_api.main:app --reload --port 8000
```

## OpenAPI / Swagger

- Interactive docs: `http://localhost:8000/docs`
- ReDoc: `http://localhost:8000/redoc`
- OpenAPI JSON: `http://localhost:8000/openapi.json`

FastAPI auto-generates schemas from Pydantic models and route signatures.

## Example requests

```bash
curl -X POST http://localhost:8000/api/v1/services \
  -H "Content-Type: application/json" \
  -d '{"name":"taskflow-api","environment":"dev","owner":"platform-team"}'

curl http://localhost:8000/api/v1/services
```

## Verify

```bash
./scripts/check.sh
python -m py_compile taskflow_platform_api/*.py taskflow_platform_api/routers/*.py
```