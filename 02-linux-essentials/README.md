# Week 2: Linux Essentials for Platform Engineers

**Slug:** `linux-essentials-platform-engineers`

Week 2 builds Linux command-line, security, service, and observability skills on **TaskFlow** — the bootcamp application from Week 1.

## TaskFlow context

TaskFlow runs on Linux in production. Week 2 labs use [`../01-devops-platform-engineering-overview/taskflow/`](../01-devops-platform-engineering-overview/taskflow/) plus local workspace files under each lab.

```bash
# Week 1 TaskFlow (reference)
cd ../01-devops-platform-engineering-overview/taskflow
docker build -t taskflow:week2 .
```

## Labs

| Directory | Focus |
|-----------|--------|
| [`lab-linux-commands/`](./lab-linux-commands/) | 50+ essential commands — navigation, files, search |
| [`lab-linux-security/`](./lab-linux-security/) | Users, groups, permissions, access control |
| [`lab-packages-services/`](./lab-packages-services/) | apt, nginx, PostgreSQL, Redis, systemd web stack |
| [`lab-server-configuration/`](./lab-server-configuration/) | Hostname, SSH, sudo, UFW, server baseline |
| [`lab-system-monitoring/`](./lab-system-monitoring/) | top, df, logs, monitoring scripts |
| [`lab-text-processing/`](./lab-text-processing/) | grep, awk, sed, pipes, log analysis |

Each lab includes `scripts/check.sh` and `scripts/solve.sh`.

## Recommended environment

- **Ubuntu 22.04+ VM** for apt, systemd, and UFW exercises
- macOS/Linux host for scripts, text processing, and Docker Compose stack lab

## Quick start

```bash
cd lab-linux-commands && ./scripts/solve.sh && ./scripts/check.sh
```

## Learning outcomes

- Command-line fluency for daily platform engineering work
- Secure multi-user layouts and server hardening fundamentals
- Service management and web stack provisioning (Ansible prep, Week 11)
- Monitoring and log analysis skills (Prometheus prep, Week 17)

## Status

Week 2 complete — 6 labs with exercises, check/solve scripts, TaskFlow-integrated workspace.