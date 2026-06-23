# Lab: FastAPI JWT & RBAC

Implement JWT authentication and role-based access control for the TaskFlow Platform API.

## What you build

- `/api/v1/auth/login` and `/api/v1/auth/me` endpoints
- JWT token creation and validation
- RBAC roles: `admin`, `operator`, `viewer`
- Protected CRUD routes with permission checks

## Quick start

```bash
./scripts/solve.sh && ./scripts/check.sh
pip install -r deliverables/requirements.txt
cd deliverables && uvicorn taskflow_platform_api.main:app --reload
```

Default users: `admin@taskflow.io` / `admin123`, `viewer@taskflow.io` / `viewer123`