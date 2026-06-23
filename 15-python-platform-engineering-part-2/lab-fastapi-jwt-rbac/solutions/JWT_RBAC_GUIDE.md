# JWT Authentication & RBAC Guide — TaskFlow

## Overview

Secure the TaskFlow Platform API with JWT tokens and role-based access control. Three roles map to platform engineering responsibilities.

## Roles & permissions

| Role | Read | Write | Delete | Admin |
|------|------|-------|--------|-------|
| `admin` | ✓ | ✓ | ✓ | ✓ |
| `operator` | ✓ | ✓ | — | — |
| `viewer` | ✓ | — | — | — |

## Authentication flow

1. `POST /api/v1/auth/login` with form fields `username` + `password`
2. Receive `access_token` (JWT)
3. Pass `Authorization: Bearer <token>` on protected routes
4. `GET /api/v1/auth/me` returns current user and role

## Default users

| Email | Password | Role |
|-------|----------|------|
| admin@taskflow.io | admin123 | admin |
| operator@taskflow.io | operator123 | operator |
| viewer@taskflow.io | viewer123 | viewer |

## Example

```bash
# Login
TOKEN=$(curl -s -X POST http://localhost:8000/api/v1/auth/login \
  -d "username=admin@taskflow.io&password=admin123" | jq -r .access_token)

# Protected read
curl -H "Authorization: Bearer $TOKEN" http://localhost:8000/api/v1/services

# Viewer cannot write (403)
curl -X POST -H "Authorization: Bearer $VIEWER_TOKEN" \
  -H "Content-Type: application/json" \
  -d '{"name":"new-svc"}' http://localhost:8000/api/v1/services
```

## Production notes

- Set `TASKFLOW_JWT_SECRET` to a strong random value
- Store users in database (SQLAlchemy from Lab 1)
- Add refresh tokens for long-lived sessions
- Integrate with Backstage GitHub OAuth (Week 13)

## Verify

```bash
./scripts/check.sh
```