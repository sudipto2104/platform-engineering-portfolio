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
| [`lab-platform-path/`](./lab-platform-path/) | Hands-on lab | End-to-end slice: Git → Docker → Terraform → scale → observe |
| [`lab-dev-environment/`](./lab-dev-environment/) | Hands-on lab | VS Code, terminal, Git, and SSH setup |
| [`lab-devops-analysis/`](./lab-devops-analysis/) | Hands-on lab | DORA metrics and DevOps maturity analysis (Meridian Retail scenario) |
| [`project-taskflow-vision/`](./project-taskflow-vision/) | Project | TaskFlow vision, features, user stories, success metrics |

Each lab includes `scripts/check.sh` (verify) and `scripts/solve.sh` (reference solution). The platform-path lab also includes `scripts/observe.sh` for logs, stats, and Terraform state.

## Quick start — platform path

```bash
cd lab-platform-path
./scripts/solve.sh    # runs full git → docker → terraform → scale pipeline
./scripts/observe.sh  # inspect running infrastructure
./scripts/check.sh    # verify lab completion
```

## Platform layers (Week 1)

```
Git (source) → Docker (image) → Terraform (IaC) → Scale (replicas) → Observe (logs/state)
```

## Learning outcomes

- Understand how major platform layers connect and hand off to each other
- See source code become a container image, then managed infrastructure
- Apply DORA metrics to assess organizational DevOps maturity
- Define TaskFlow's vision with business-aligned platform thinking

## Status

Week 1 coursework complete — labs, TaskFlow stub, check/solve scripts, and reference solutions in place.