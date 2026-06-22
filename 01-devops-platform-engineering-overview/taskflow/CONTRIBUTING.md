# Contributing to TaskFlow

Thank you for improving TaskFlow. This project is part of a 21-week platform engineering bootcamp — contributions should stay focused, tested, and documented.

## Getting started

1. Fork the repository and create a branch from `main`.
2. Set up locally: `pip install -r requirements.txt && python app.py`
3. Make changes in small, reviewable commits.

## Development standards

- **Python 3.11+** — match `Dockerfile` base image.
- **API changes** require updates to `docs/API.md`.
- **Architecture changes** require updates to `docs/ARCHITECTURE.md`.
- Keep Week 1 scope minimal; defer large features to later bootcamp weeks.

## Commit messages

Use conventional commits:

```
feat: add task filter by status
fix: correct health timestamp timezone
docs: update API examples
```

## Pull request checklist

- [ ] `curl http://localhost:8080/health` returns healthy
- [ ] `curl http://localhost:8080/api/tasks` returns expected JSON
- [ ] Documentation updated if behavior changed
- [ ] Docker build succeeds: `docker build -t taskflow:week1 .`

## Code review expectations

- One approving review for functional changes
- Platform-team-owned paths (`Dockerfile`, `docs/`) need doc updates in the same PR

## Reporting issues

Include: steps to reproduce, expected vs. actual, environment (local/Docker), and Week number if bootcamp-specific.

## Questions

Open a discussion in the portfolio repository or follow bootcamp lab instructions for your cohort.