# Text Processing Drills

```bash
LOG=../../taskflow-workspace/logs/taskflow.log
```

## grep

```bash
grep ERROR "$LOG"
grep -E 'duration_ms=[0-9]{4,}' "$LOG"
grep -c WARN "$LOG"
```

## awk

```bash
awk '/ERROR/ {print $1, $3}' "$LOG"
awk -F'duration_ms=' '/api\/tasks/ {sum+=$2;n++} END {print sum/n}'
```

## sed

```bash
sed -n '1,5p' "$LOG"
sed 's/INFO/INFO ✓/' "$LOG" | head
```

## Pipes

```bash
grep GET "$LOG" | awk '{print $4}' | sort | uniq -c | sort -rn
cat "$LOG" | wc -l
./automation/analyze-taskflow-logs.sh
```