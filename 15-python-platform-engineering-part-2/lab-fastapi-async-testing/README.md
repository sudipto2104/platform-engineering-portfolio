# Lab: FastAPI Async & Testing

Implement asynchronous operations, background tasks, and a pytest test suite for the TaskFlow Platform API.

## What you build

- Async deployment status endpoint with `httpx`
- `BackgroundTasks` for simulated rollout workflows
- Job tracking for long-running platform operations
- pytest suite with `TestClient` fixtures

## Quick start

```bash
./scripts/solve.sh && ./scripts/check.sh
pip install -r deliverables/requirements.txt
cd deliverables && pytest tests/ -v
```