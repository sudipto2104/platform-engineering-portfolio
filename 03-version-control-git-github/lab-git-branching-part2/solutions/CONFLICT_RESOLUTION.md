# Merge Conflict Resolution (Reference)

## Scenario

Two branches changed `TASKFLOW_VERSION` default in `app.py` — merge produced conflict markers.

## Resolution steps

1. `git merge fix/99-version-label` → conflict
2. Open `app.py`, remove `<<<<<<<`, `=======`, `>>>>>>>`
3. Choose correct combined value: `week3-resolved`
4. `git add app.py && git commit`

## Interactive rebase

```bash
git checkout feature/my-branch
git rebase -i main
# squash fixup commits before PR
```

## Cherry-pick

```bash
git cherry-pick <sha>   # apply single commit to current branch
```

Used to backport hotfix from `main` to release branch.

## Stash recovery

```bash
git stash list
git stash pop
```