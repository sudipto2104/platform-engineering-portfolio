# Security Drills

## Drill 1 — Inspect permissions

```bash
ls -la workspace/taskflow-server/
stat workspace/taskflow-server/config/app.env
```

## Drill 2 — Ubuntu user & group setup (VM)

```bash
sudo groupadd platform
sudo groupadd ops
sudo useradd -m -G platform dev1
sudo useradd -r -s /usr/sbin/nologin taskflow
```

## Drill 3 — Fix permissions

```bash
./scripts/solve.sh
find workspace/taskflow-server -type f -exec ls -l {} \;
```

## Drill 4 — Sudo policy (VM)

```bash
sudo visudo -f /etc/sudoers.d/taskflow
# taskflow ALL=(root) NOPASSWD: /bin/systemctl restart taskflow
```

Document findings in `deliverables/SECURITY_AUDIT.md`.