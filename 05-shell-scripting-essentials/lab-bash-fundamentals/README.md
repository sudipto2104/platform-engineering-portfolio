# Lab: Bash Scripting Fundamentals

Build five platform utility scripts: file backup, log rotation, system info, disk monitoring, and automated cleanup.

## Scripts (reference solutions)

| Script | Purpose |
|--------|---------|
| `backup_files.sh` | Timestamped directory backup with tar |
| `rotate_logs.sh` | Compress and rotate log files |
| `system_info.sh` | Hostname, uptime, memory, load |
| `disk_monitor.sh` | Warn when disk usage exceeds threshold |
| `cleanup_temp.sh` | Remove stale files from a temp directory |

## Workspace

Sample data under `workspace/` — logs, app files, temp artifacts.

```bash
./scripts/solve.sh && ./scripts/check.sh
```