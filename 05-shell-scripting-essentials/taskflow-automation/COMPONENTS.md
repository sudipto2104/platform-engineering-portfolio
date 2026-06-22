# TaskFlow Automation Targets (Week 5)

TaskFlow is the bootcamp's running application. Week 5 scripts automate platform tasks around this stack:

| Component | Role | Automation touchpoints |
|-----------|------|----------------------|
| Frontend | React + TypeScript UI | Dependency install, build validation |
| Backend | Node.js/Express API | Config deploy, health probes |
| Database | PostgreSQL | Schema init, connection checks |
| Cache | Redis | Ping checks, config validation |
| API | REST (tasks, users, projects) | Smoke tests via curl |

**Local practice repo:** `03-version-control-git-github/taskflow-sandbox/` (Flask API for health/tasks endpoints).

Capstone scripts support `--mode sandbox` for the Week 3 sandbox and `--mode full` for the documented production layout.