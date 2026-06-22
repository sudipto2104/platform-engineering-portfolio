# TaskFlow Server Security Audit (Reference)

## Scope

Simulated multi-user TaskFlow host: app, config, logs, data, public directories.

## Findings (before hardening)

| Issue | Risk | Remediation |
|-------|------|-------------|
| `config/app.env` world-readable | Secret leakage | `chmod 640`, group `platform` |
| `data/tasks.json` world-readable | Data exposure | `chmod 600` |
| `logs/` world-writable | Log injection | `chmod 770`, group `ops` |
| Shared SSH keys | Account compromise | Per-user keys, `PermitRootLogin no` |

## Groups model (production Ubuntu)

| Group | Members | Access |
|-------|---------|--------|
| `platform` | platform engineers | app/, config/ read |
| `ops` | SRE/on-call | logs/ read, restart services |
| `taskflow` | service account | run app, no login shell |

## Permission matrix (after solve)

| Path | Perms | Owner concept |
|------|-------|---------------|
| `config/app.env` | 640 | root:platform |
| `data/tasks.json` | 600 | taskflow:taskflow |
| `logs/taskflow.log` | 660 | taskflow:ops |
| `public/` | 755 | root:root |

## Best practices applied

- Least privilege on secrets (`600`/`640`)
- Separation of duties via groups
- No execute on data files
- Documented sudo rules for service restarts only

## Ubuntu commands (VM)

```bash
sudo groupadd platform
sudo useradd -r -s /usr/sbin/nologin taskflow
sudo chown -R taskflow:platform /opt/taskflow/app
sudo chmod 640 /opt/taskflow/config/app.env
```