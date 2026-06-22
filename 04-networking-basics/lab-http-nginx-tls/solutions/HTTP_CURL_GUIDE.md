# HTTP & curl Guide — TaskFlow (Reference)

## Methods & status codes

| Method | TaskFlow use | Typical code |
|--------|--------------|--------------|
| GET | `/health`, `/api/tasks` | 200 |
| POST | Create task (future) | 201 |
| PUT/PATCH | Update task | 200 |
| DELETE | Remove task | 204 |

| Code | Meaning |
|------|---------|
| 200 | OK |
| 404 | Route not found |
| 500 | Server error |
| 502 | Bad gateway (Nginx → dead upstream) |

## curl exercises

```bash
# Basic GET
curl -s http://localhost:8090/health | python3 -m json.tool

# Verbose headers
curl -v http://localhost:8090/health

# Show response headers only
curl -I http://localhost:8090/health

# HTTPS (self-signed — -k for lab only)
curl -vk https://localhost:8443/health

# Custom header
curl -H "X-Request-ID: lab-week4" http://localhost:8090/api/tasks

# Timing
curl -w "@curl-format.txt" -o /dev/null -s http://localhost:8090/health
```

## HTTP vs HTTPS

| | HTTP :8090 | HTTPS :8443 |
|---|------------|-------------|
| Encryption | None | TLS 1.2+ |
| Certificates | N/A | `certs/taskflow.crt` |
| Use | Dev only | Staging/prod pattern |

## Common errors

- **502 Bad Gateway** — TaskFlow container down; check `docker compose ps`
- **SSL certificate problem** — use `-k` in lab or trust CA cert
- **Connection refused** — wrong port or service not started