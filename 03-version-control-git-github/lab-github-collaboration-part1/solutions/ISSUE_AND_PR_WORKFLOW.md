# Issue & PR Workflow (Reference)

## Sample issue #12

**Title:** Add task count to API response metadata  
**Labels:** `enhancement`, `taskflow`  
**Body:** Include `count` field (already present) and document in API.md.

## Sample PR #15

**Title:** feat: document task count in API (#12)  
**Branch:** `feature/12-task-count-docs`  
**Closes:** #12

### Commit linking

```
feat: document task count in API

Closes #12
```

## PR etiquette

- Small, focused diffs (< 400 lines)
- Self-review before requesting others
- Link issue in PR description
- Respond to feedback within 1 business day
- Ensure CI green before review request

## Merge strategy preview

| Strategy | When |
|----------|------|
| Squash merge | Feature branches (default) |
| Rebase merge | Linear history teams |
| Merge commit | Release branches |