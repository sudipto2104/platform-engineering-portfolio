# Week 1: DevOps & Platform Engineering Overview

**Slug:** `devops-platform-engineering-overview`

Week 1 introduces the platform engineering stack and establishes **TaskFlow** — the task management application that grows across all 21 bootcamp weeks.

## TaskFlow application

The shared codebase lives in [`taskflow/`](./taskflow/). Week 1 ships a minimal Flask API with health checks and a task list. Each subsequent week adds platform capabilities (containers, IaC, Kubernetes, observability, and more).

```bash
cd taskflow
pip install -r requirements.txt && python app.py
# or: docker build -t taskflow:week1 . && docker run --rm -p 8080:8080 taskflow:week1
```

## Labs and projects

| Directory | Type | What you do |
|-----------|------|-------------|
| [`lab-platform-path/`](./lab-platform-path/) | Lab | End-to-end slice: Git → Docker → Terraform → scale → observe |
| [`lab-dev-environment/`](./lab-dev-environment/) | Lab | VS Code, terminal, Git, and SSH setup |
| [`lab-devops-analysis/`](./lab-devops-analysis/) | Lab | DORA metrics and DevOps maturity (Meridian Retail) |
| [`lab-idp-strategy/`](./lab-idp-strategy/) | Lab | IDP strategy consulting for NovaStream startup |
| [`project-taskflow-vision/`](./project-taskflow-vision/) | Project | Vision, features, user stories, success metrics |
| [`project-taskflow-documentation/`](./project-taskflow-documentation/) | Project | README, CONTRIBUTING, architecture and API docs |
| [`project-taskflow-architecture/`](./project-taskflow-architecture/) | Project | Technology decisions, system diagrams, component interactions |

Each lab and project includes `scripts/check.sh` (verify) and `scripts/solve.sh` (reference solution). The platform-path lab also includes `scripts/observe.sh`.

## Quick start

**Platform path (hands-on toolchain):**

```bash
cd lab-platform-path
./scripts/solve.sh && ./scripts/observe.sh && ./scripts/check.sh
```

**Documentation (publish to TaskFlow):**

```bash
cd project-taskflow-documentation
./scripts/solve.sh && ./scripts/check.sh
```

## Platform layers (Week 1)

```
Git (source) → Docker (image) → Terraform (IaC) → Scale (replicas) → Observe (logs/state)
```

## Learning outcomes

- Connect major platform layers and understand handoffs between them
- Think strategically about IDP capabilities, team structure, and roadmaps
- Apply DORA metrics to organizational DevOps maturity
- Define TaskFlow vision and technical architecture before deep implementation
- Produce portfolio-grade documentation employers can evaluate on GitHub

## Status

Week 1 complete — 4 labs, 3 projects, TaskFlow stub, check/solve scripts, and reference solutions.