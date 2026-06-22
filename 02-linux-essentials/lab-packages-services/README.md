# Lab: Packages & Services — TaskFlow Web Stack

Master **apt**, **systemd**, and a complete web stack: **nginx**, **PostgreSQL**, **Redis** — the foundation you'll automate with Ansible in Week 11.

## Two paths

| Environment | Approach |
|-------------|----------|
| **Ubuntu VM** | Native `apt install` + systemd units in `reference/systemd/` |
| **Any host with Docker** | `docker compose up` (portable stack) |

## Stack architecture

```
Client → nginx:80 → TaskFlow API:8080
                    ↘ PostgreSQL (tasks)
                    ↘ Redis (cache)
```

## Verify

```bash
./scripts/check.sh
```

## Solution

```bash
./scripts/solve.sh
```