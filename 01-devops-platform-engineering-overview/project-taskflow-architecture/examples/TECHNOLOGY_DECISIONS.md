# Technology Decisions — TaskFlow (Reference)

## ADR-001: Python as primary language

- **Status:** Accepted
- **Context:** Bootcamp includes Python platform engineering weeks; team familiarity is high.
- **Decision:** Python 3.11 for application and automation glue.
- **Alternatives considered:** Go (better single-binary deploys), Node (frontend synergy).
- **Consequences:** Fast iteration; GIL limits CPU-bound workloads — acceptable for task API.

## ADR-002: Flask for Week 1 HTTP layer

- **Status:** Accepted
- **Context:** Week 1 needs minimal API surface, not async throughput.
- **Decision:** Flask 3.x with Gunicorn in production containers.
- **Alternatives considered:** FastAPI (OpenAPI native), Django (too heavy).
- **Consequences:** Manual API docs in `docs/API.md` until OpenAPI added later.

## ADR-003: In-memory store (Week 1)

- **Status:** Accepted (temporary)
- **Context:** Avoid database operations before data/persistence weeks.
- **Decision:** Python list `TASKS` in `app.py`.
- **Alternatives considered:** SQLite (simple file DB), PostgreSQL (production-grade).
- **Consequences:** Data lost on restart; migration ADR required by Week 6.

## ADR-004: Docker as deployment unit

- **Status:** Accepted
- **Context:** Week 1 lab-platform-path teaches image → IaC handoff.
- **Decision:** OCI image `taskflow:week1` from `python:3.11-slim`.
- **Alternatives considered:** VM packages, serverless functions.
- **Consequences:** Requires container runtime everywhere; aligns with K8s weeks.

## ADR-005: Terraform docker provider (Week 1 IaC)

- **Status:** Accepted (bootcamp scope)
- **Context:** Teach IaC before cloud accounts are mandatory.
- **Decision:** `kreuzwerker/docker` provider manages local replicas.
- **Alternatives considered:** Docker Compose only, AWS ECS immediately.
- **Consequences:** Not production multi-host; replaced by cloud IaC in Week 10+.

## ADR-006: JSON REST API

- **Status:** Accepted
- **Context:** Labs verify with `curl`; IDP integrations need stable contract.
- **Decision:** REST-ish JSON under `/api/*` with `/health` probe.
- **Alternatives considered:** gRPC (ops complexity), GraphQL (overkill Week 1).
- **Consequences:** Version via env until `/v1/` prefix introduced.