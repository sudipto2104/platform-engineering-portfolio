# Branching Log (Reference)

## Feature branch workflow

1. `git checkout main && git pull`
2. `git checkout -b feature/12-add-task-count`
3. Commit with conventional messages
4. `git checkout main && git merge --no-ff feature/12-add-task-count`

## Stash

Saved WIP before switching branches — restored with `git stash pop`.

## Rebase vs merge

| Strategy | When |
|----------|------|
| **Merge** | Preserve branch context on shared main |
| **Rebase** | Linear history on feature branch before PR (Part 2) |

## Naming

See `reference/BRANCH_NAMING.md` — always include issue id when available.