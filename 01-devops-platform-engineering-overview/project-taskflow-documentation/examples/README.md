# TaskFlow

Task management platform for the 21-week Platform Engineering bootcamp. TaskFlow grows each week as new platform capabilities are added — containers, IaC, Kubernetes, observability, and more.

## Prerequisites

- Python 3.11+
- Docker (optional, recommended from Week 1 lab)
- `curl` or HTTP client for API checks

## Quick start (local)

```bash
pip install -r requirements.txt
python app.py
```

Verify:

```bash
curl -s http://localhost:8080/health | python3 -m json.tool
curl -s http://localhost:8080/api/tasks | python3 -m json.tool
```

## Quick start (Docker)

```bash
docker build -t taskflow:week1 .
docker run --rm -p 8080:8080 --name taskflow taskflow:week1
```

## Environment variables

| Variable | Default | Description |
|----------|---------|-------------|
| `PORT` | `8080` | HTTP listen port |
| `TASKFLOW_VERSION` | `week1` | Version string in `/health` |

## Project structure

```
taskflow/
├── app.py              # Flask application
├── requirements.txt    # Python dependencies
├── Dockerfile          # Container image
├── CONTRIBUTING.md     # Contributor guide
└── docs/
    ├── ARCHITECTURE.md # System design
    └── API.md          # API reference
```

## Bootcamp integration

Week 1 labs use TaskFlow as the application under platform engineering:

- [`lab-platform-path`](../lab-platform-path/) — Git → Docker → Terraform
- [`project-taskflow-vision`](../project-taskflow-vision/) — Product vision
- [`project-taskflow-architecture`](../project-taskflow-architecture/) — Technical design

## License

Bootcamp portfolio project — see repository root for terms.