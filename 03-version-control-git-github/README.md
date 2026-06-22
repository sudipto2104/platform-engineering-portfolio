# Week 3: Git, GitHub & CI/CD Fundamentals

**Slug:** `git-github-cicd-fundamentals`

Week 3 applies professional **Git**, **GitHub collaboration**, and **CI/CD quality gates** to **TaskFlow** — the bootcamp application from Week 1.

## TaskFlow sandbox

Hands-on Git work uses [`taskflow-sandbox/`](./taskflow-sandbox/) — a practice copy of TaskFlow. Week 1 canonical source remains at [`../01-devops-platform-engineering-overview/taskflow/`](../01-devops-platform-engineering-overview/taskflow/).

## Labs (in order)

| Directory | Focus |
|-----------|--------|
| [`lab-git-fundamentals-part1/`](./lab-git-fundamentals-part1/) | Configure Git, commits, staging, push/pull basics |
| [`lab-git-fundamentals-part2/`](./lab-git-fundamentals-part2/) | Remote sync, `git log`, blame, bisect |
| [`lab-git-branching-part1/`](./lab-git-branching-part1/) | Feature branches, stash, naming conventions |
| [`lab-git-branching-part2/`](./lab-git-branching-part2/) | Conflicts, rebase, cherry-pick |
| [`lab-github-collaboration-part1/`](./lab-github-collaboration-part1/) | Issues, PR workflow, linking work |
| [`lab-github-collaboration-part2/`](./lab-github-collaboration-part2/) | Reviews, merge strategies, branch cleanup |
| [`lab-cicd-code-quality-part1/`](./lab-cicd-code-quality-part1/) | Lint, format, security scans, quality gates |
| [`lab-cicd-code-quality-part2/`](./lab-cicd-code-quality-part2/) | Enforce gates in Actions + branch protection |

Each lab includes `scripts/check.sh` and `scripts/solve.sh`.

## Quick start

```bash
cd lab-git-fundamentals-part1
./scripts/solve.sh && ./scripts/check.sh
```

## Status

Week 3 complete — 8 labs, TaskFlow sandbox, GitHub Actions CI templates, check/solve scripts.