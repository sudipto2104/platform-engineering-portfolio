# Lab: TaskFlow Setup Automation (Capstone)

Automate TaskFlow environment validation, dependency install, configuration, database init, and health checks.

Uses the Week 3 sandbox at `../../03-version-control-git-github/taskflow-sandbox/`.

```bash
./scripts/solve.sh && ./scripts/check.sh
```

## Modes

| Mode | Description |
|------|-------------|
| `sandbox` | Flask API sandbox — local pip + health curl |
| `full` | Documented full stack (React, Node, PostgreSQL, Redis) |