# PR Review & Merge Guide (Reference)

## Review checklist

- [ ] CI checks green
- [ ] Scope matches issue
- [ ] No secrets in diff
- [ ] Tests / health check documented
- [ ] Breaking API changes called out

## Sample review comments

| Severity | Comment |
|----------|---------|
| **nit** | Consider renaming variable for clarity |
| **suggestion** | Add error handling for empty task list |
| **blocker** | Remove hardcoded credential before merge |

## Merge strategies

| Strategy | Result | TaskFlow default |
|----------|--------|------------------|
| **Squash and merge** | One commit on main | ✅ Feature PRs |
| **Rebase and merge** | Linear commits | Optional |
| **Create merge commit** | Preserves branch topology | Release merges |

## After merge

```bash
git checkout main
git pull
git branch -d feature/12-task-count-docs
git push origin --delete feature/12-task-count-docs
```

Keeps repository tidy — critical for portfolio reviewers.