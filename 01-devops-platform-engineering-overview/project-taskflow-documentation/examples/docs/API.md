# TaskFlow API Reference (Week 1)

Base URL: `http://localhost:8080` (local or container)

All responses are `application/json`.

## Endpoints

### `GET /`

Service index and endpoint discovery.

**Response 200**

```json
{
  "message": "Welcome to TaskFlow",
  "description": "Task management platform for the Platform Engineering bootcamp",
  "endpoints": ["/health", "/api/tasks"]
}
```

---

### `GET /health`

Liveness and version probe for orchestrators and observability.

**Response 200**

```json
{
  "status": "healthy",
  "service": "taskflow",
  "version": "week1",
  "timestamp": "2026-06-22T12:00:00+00:00"
}
```

| Field | Type | Description |
|-------|------|-------------|
| `status` | string | `healthy` when process is up |
| `service` | string | Service identifier |
| `version` | string | From `TASKFLOW_VERSION` env |
| `timestamp` | string | ISO 8601 UTC |

---

### `GET /api/tasks`

List all tasks (Week 1 in-memory dataset).

**Response 200**

```json
{
  "tasks": [
    {
      "id": 1,
      "title": "Set up dev environment",
      "status": "done",
      "owner": "platform-team"
    }
  ],
  "count": 3
}
```

**Task object**

| Field | Type | Values |
|-------|------|--------|
| `id` | integer | Unique identifier |
| `title` | string | Task title |
| `status` | string | `todo`, `in_progress`, `done` |
| `owner` | string | Team or person responsible |

## Examples

```bash
# Health
curl -s http://localhost:8080/health | python3 -m json.tool

# Tasks
curl -s http://localhost:8080/api/tasks | python3 -m json.tool

# Root
curl -s http://localhost:8080/ | python3 -m json.tool
```

## Errors (Week 1)

Unknown paths return Flask default 404 HTML. Structured error JSON added in later weeks.

## Versioning

Week 1 uses path-less versioning via `TASKFLOW_VERSION` in `/health`. URL prefix versioning (`/v1/`) planned when breaking changes begin.