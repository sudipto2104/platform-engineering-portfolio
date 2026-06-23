# Lab: FastAPI Platform API

Build a production-ready RESTful API for TaskFlow infrastructure management using FastAPI, SQLAlchemy, and Pydantic.

## What you build

- CRUD endpoints for platform resources (services, environments)
- SQLAlchemy ORM with SQLite
- Pydantic request/response validation
- Auto-generated OpenAPI/Swagger docs at `/docs`

## Quick start

```bash
./scripts/solve.sh && ./scripts/check.sh
pip install -r deliverables/requirements.txt
cd deliverables && uvicorn taskflow_platform_api.main:app --reload
```

Open `http://localhost:8000/docs` for interactive API documentation.