# Command Practice Log (Reference)

**Student:** Platform Engineering Bootcamp  
**Date:** 2026-06-22  
**Environment:** Ubuntu 22.04 VM + TaskFlow workspace

## Summary

| Category | Commands practiced | Confidence (1–5) |
|----------|-------------------|------------------|
| Navigation | 8 | 5 |
| File operations | 12 | 4 |
| Viewing files | 10 | 5 |
| Searching | 8 | 5 |
| Processes/system | 10 | 4 |
| Networking | 6 | 4 |
| Archives/pipes | 6 | 3 |
| **Total unique** | **52** | |

## Notable TaskFlow commands run

```bash
find ../../01-devops-platform-engineering-overview/taskflow -name '*.py'
grep ERROR ../taskflow-workspace/logs/taskflow.log | wc -l    # → 6 errors
tail -f ../taskflow-workspace/logs/taskflow.log
curl -s http://localhost:8080/health
du -sh ../../01-devops-platform-engineering-overview/taskflow
```

## Observations

- `grep -r` essential for tracing TaskFlow endpoint definitions across files.
- `tail -f` is the first tool for live deploy verification before Prometheus (Week 17).
- `find` + `chmod` combination appears again in security lab.

## Gaps to revisit

- `tar` archive of TaskFlow logs for incident bundles
- `journalctl` on Ubuntu (covered in monitoring lab)