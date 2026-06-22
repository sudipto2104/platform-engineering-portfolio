# Command Drills — TaskFlow Workspace

Run on Ubuntu VM or local shell. TaskFlow repo path may vary — adjust `TASKFLOW` below.

```bash
export TASKFLOW=../../01-devops-platform-engineering-overview/taskflow
export LOGS=../taskflow-workspace/logs
```

## Drill 1 — Navigation

```bash
pwd
cd "$TASKFLOW" && ls -la
cd - && pushd "$LOGS" && ls && popd
```

## Drill 2 — File operations

```bash
mkdir -p /tmp/taskflow-lab/{config,logs,backup}
touch /tmp/taskflow-lab/config/app.env
cp "$TASKFLOW/app.py" /tmp/taskflow-lab/backup/
find /tmp/taskflow-lab -type f
```

## Drill 3 — Viewing

```bash
head -5 "$TASKFLOW/app.py"
tail -3 "$LOGS/taskflow.log"
wc -l "$LOGS/taskflow.log"
less "$LOGS/taskflow.log"    # press q to quit
```

## Drill 4 — Searching

```bash
grep ERROR "$LOGS/taskflow.log"
grep -c WARN "$LOGS/taskflow.log"
grep -r "health" "$TASKFLOW" --include="*.py"
which python3 docker git
```

## Drill 5 — System snapshot

```bash
df -h
du -sh "$TASKFLOW"
ps aux | head -5
uname -a
```

Record command counts and observations in `deliverables/COMMAND_PRACTICE_LOG.md`.