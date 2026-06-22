# Week 5: Bash Scripting & Automation

**Slug:** `bash-scripting-automation`

Week 5 builds production-style Bash automation for **TaskFlow** — from utility scripts through functions, loops, and a full setup automation suite.

## TaskFlow context

Scripts target TaskFlow operations across environments. The capstone lab wires automation to [`../03-version-control-git-github/taskflow-sandbox/`](../03-version-control-git-github/taskflow-sandbox/). Shared reference: [`taskflow-automation/`](./taskflow-automation/).

## Labs

| Directory | Focus |
|-----------|--------|
| [`lab-bash-fundamentals/`](./lab-bash-fundamentals/) | Variables, I/O, 5 platform utility scripts |
| [`lab-conditionals-health-check/`](./lab-conditionals-health-check/) | if/else/case, validation, system health checks |
| [`lab-loops-automation/`](./lab-loops-automation/) | for/while/until, arrays, batch processing |
| [`lab-functions-libraries/`](./lab-functions-libraries/) | Functions, scope, libraries, modular deploy |
| [`lab-taskflow-setup-automation/`](./lab-taskflow-setup-automation/) | Capstone — full TaskFlow setup automation |

Each lab includes `scripts/check.sh` and `scripts/solve.sh`.

## Quick start

```bash
cd lab-bash-fundamentals && ./scripts/solve.sh && ./scripts/check.sh
```

## Status

Week 5 complete — 5 labs, TaskFlow automation suite, check/solve scripts.