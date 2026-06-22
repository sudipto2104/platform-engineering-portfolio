# Containerization Guide

## Backend (FastAPI)

- **Base:** `python:3.11-slim`
- **Health:** `GET /health` in `main.py` + Dockerfile `HEALTHCHECK`
- **Run:** `uvicorn main:app --host 0.0.0.0 --port 8080`

```bash
docker build -f Dockerfile.backend -t taskflow-api:week7 ../taskflow-stack/backend
docker run --rm -p 8080:8080 taskflow-api:week7
curl http://localhost:8080/health
```

## Frontend (Vue + Nginx)

- **Build stage:** `node:20-alpine` → `npm run build`
- **Runtime:** `nginx:1.25-alpine` serves `dist/`
- **Build args:** `VITE_APP_ENV`, `VITE_API_URL`, `VITE_BUILD_ID`

```bash
docker build -f Dockerfile.frontend -t taskflow-ui:week7 ../taskflow-stack/frontend
docker run --rm -p 8081:80 taskflow-ui:week7
```