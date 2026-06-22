# Lab: Platform Automation Thinking

Learn how platform engineers decide **what to automate**, build **reliable scripts**, and **document reasoning** — using real TaskFlow workflows from the bootcamp.

## Scenario

Platform engineers on the TaskFlow team perform these manual steps every day:

```bash
cat scenario/MANUAL_WORKFLOWS.md
```

Your job: analyze the toil, automate the high-value paths, and document what you deliberately left manual.

## Steps

### 1. Analyze manual workflows

Complete `deliverables/WORKFLOW_ANALYSIS.md` using `templates/`.

### 2. Build automation scripts

Implement (or extend) scripts in `automation/`:

| Script | Purpose |
|--------|---------|
| `taskflow-setup.sh` | Idempotent local dev setup |
| `taskflow-health.sh` | Health probe with logging and exit codes |
| `taskflow-smoke.sh` | API smoke tests |

Reference implementations are in `solutions/automation/`.

### 3. Document decisions

Complete `deliverables/AUTOMATION_DECISIONS.md` — when you automated, when you did not, and why.

### 4. Verify

```bash
./scripts/check.sh
```

## Solution

```bash
./scripts/solve.sh
```

Runs reference automations against TaskFlow and populates deliverables.