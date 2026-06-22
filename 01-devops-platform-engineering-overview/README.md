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

## Labs

| Directory | What you do |
|-----------|-------------|
| [`lab-platform-path/`](./lab-platform-path/) | Git → Docker → Terraform → scale → observe |
| [`lab-dev-environment/`](./lab-dev-environment/) | VS Code, terminal, Git, SSH setup |
| [`lab-devops-analysis/`](./lab-devops-analysis/) | DORA metrics and DevOps maturity (Meridian Retail) |
| [`lab-idp-strategy/`](./lab-idp-strategy/) | IDP strategy consulting (NovaStream) |
| [`lab-platform-automation/`](./lab-platform-automation/) | Automation thinking — scripts, idempotence, logging |

## Projects

| Directory | What you do |
|-----------|-------------|
| [`project-taskflow-vision/`](./project-taskflow-vision/) | Vision, features, user stories, metrics |
| [`project-taskflow-documentation/`](./project-taskflow-documentation/) | README, CONTRIBUTING, architecture & API docs |
| [`project-taskflow-architecture/`](./project-taskflow-architecture/) | ADRs, diagrams, component interactions |
| [`project-taskflow-development-plan/`](./project-taskflow-development-plan/) | MVP, 20-week sprint plan, risk register |
| [`project-devops-transformation/`](./project-devops-transformation/) | **Capstone** — maturity, strategy, ROI, prototypes |

Each lab and project includes `scripts/check.sh` and `scripts/solve.sh`. Platform-path also has `scripts/observe.sh`.

## Quick start

```bash
# Automation lab
cd lab-platform-automation && ./scripts/solve.sh && ./scripts/check.sh

# Transformation capstone
cd project-devops-transformation && ./scripts/solve.sh && ./scripts/check.sh

# Development plan
cd project-taskflow-development-plan && ./scripts/solve.sh && ./scripts/check.sh
```

## Platform layers (Week 1)

```
Git (source) → Docker (image) → Terraform (IaC) → Scale (replicas) → Observe (logs/state)
```

## Learning outcomes

- Connect platform layers and automate repetitive workflows responsibly
- Think strategically about IDP design and DevOps transformation
- Produce portfolio-grade documentation, architecture, and executive business cases
- Plan TaskFlow delivery across the full 21-week bootcamp

## Status

Week 1 complete — 5 labs, 5 projects, TaskFlow stub, check/solve scripts, reference solutions.