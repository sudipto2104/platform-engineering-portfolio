# Git Setup Log (Reference)

## Configuration

```bash
git config user.name "TaskFlow Student"
git config user.email "student@taskflow.local"
git config init.defaultBranch main
```

## Repository initialized

- Path: `taskflow-sandbox/`
- Initial commit: `feat: initial TaskFlow week3 sandbox`
- Follow-up: `docs: note week3 git practice`

## Staging workflow observed

| Step | Command | Result |
|------|---------|--------|
| Untracked | `git status` | README, app.py listed |
| Stage | `git add .` | Green staged files |
| Commit | `git commit -m "..."` | Hash recorded in log |

## History snapshot

```
git log --oneline -5
```

## Push readiness

Remote not yet configured — completed in Git Fundamentals Part 2.