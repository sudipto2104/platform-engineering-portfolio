# Git History Report (Reference)

## Remote workflow

```bash
git remote add origin <url>
git push -u origin main
git pull origin main
```

Simulated with local bare repo `workspace/taskflow-remote.git`.

## git log techniques

| Command | Use |
|---------|-----|
| `git log --oneline --graph` | Visual history |
| `git log --author="..."` | Filter by author |
| `git log -S "TASKS"` | Pickaxe — when string changed |
| `git log -- app.py` | File history |

## git blame

Identifies commit per line — used for incident "who changed health endpoint?"

## git bisect (basics)

```bash
git bisect start
git bisect bad
git bisect good <known-good-sha>
# test, then git bisect good|bad until culprit found
git bisect reset
```

Use when TaskFlow regression appears between two releases.