# System Architecture — TaskFlow (Reference)

## Architecture goals

1. **Teachable** — each bootcamp week adds one platform layer without rewrites.
2. **Observable** — health endpoint from day one; metrics/traces added Week 17.
3. **Portable** — runs locally, in Docker, and on orchestrators.
4. **Portfolio-ready** — documentation and diagrams employers can skim on GitHub.

## Logical architecture

```mermaid
flowchart TB
  subgraph clients [Clients]
    Dev[Developer CLI/curl]
    IDP[Future IDP portal]
  end

  subgraph taskflow [TaskFlow Service]
    API[Flask API layer]
    Domain[Task domain logic]
    Store[(Data store)]
  end

  subgraph platform [Platform layers - evolve weekly]
    CICD[CI/CD]
    IaC[Terraform / IaC]
    Orch[Kubernetes]
    Obs[Observability]
  end

  Dev --> API
  IDP --> API
  API --> Domain
  Domain --> Store
  CICD --> taskflow
  IaC --> taskflow
  Orch --> taskflow
  Obs --> API
```

## Physical / deployment architecture (Week 1)

```mermaid
flowchart LR
  subgraph host [Developer machine / VM]
    subgraph containers [Docker]
      R1[taskflow-replica-1 :9080]
      R2[taskflow-replica-2 :9081]
      R3[taskflow-replica-3 :9082]
    end
    TF[Terraform state]
  end

  User[Engineer] -->|terraform apply| TF
  TF --> R1
  TF --> R2
  TF --> R3
  User -->|curl /health| R1
```

## Boundaries and responsibilities

| Layer | Components | Owns |
|-------|------------|------|
| Application | `app.py`, Gunicorn | HTTP contract, task semantics |
| Packaging | `Dockerfile`, image | Reproducible runtime |
| Provisioning | Terraform `main.tf` | Replica count, ports, labels |
| Operations | `observe.sh`, Docker logs | Runtime inspection (Week 1) |

## Non-functional requirements

| NFR | Target | How architecture supports it |
|-----|--------|------------------------------|
| Availability | Best-effort Week 1 | Multiple replicas via Terraform `count` |
| Latency | < 100ms p95 local | In-memory reads, 2 Gunicorn workers |
| Portability | Linux container | Slim Python base image |
| Security | Dev-only Week 1 | No auth; secrets in Week 18 |
| Evolvability | Weekly increments | Clear layer boundaries in diagrams |