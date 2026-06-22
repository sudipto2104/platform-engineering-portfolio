# TaskFlow Server Baseline Checklist (Reference)

**Target host:** `taskflow-staging-01`  
**OS:** Ubuntu 22.04 LTS

## Hostname & identity

- [x] Hostname set: `sudo hostnamectl set-hostname taskflow-staging-01`
- [x] `/etc/hosts` contains `127.0.1.1 taskflow-staging-01`
- [x] `hostnamectl` shows static hostname

## Network

- [x] Primary interface has static/reserved IP documented
- [x] DNS resolves `github.com`, `registry-1.docker.io`
- [x] `ss -tuln` shows only expected listeners (22, 80, 443)

## Users & sudo

- [x] Deploy user `deploy` in `sudo` group with NOPASSWD for `systemctl restart taskflow` only
- [x] Service account `taskflow` has `/usr/sbin/nologin` shell
- [x] No shared human accounts

## SSH hardening

- [x] Key-based auth enabled (`PubkeyAuthentication yes`)
- [x] Root login disabled (`PermitRootLogin no`)
- [x] Password auth disabled (`PasswordAuthentication no`)
- [x] Test: `ssh -i ~/.ssh/id_ed25519 deploy@taskflow-staging-01`

## Firewall (UFW)

- [x] Default deny incoming
- [x] Allow 22/tcp (admin CIDR only if possible)
- [x] Allow 80, 443/tcp
- [x] `sudo ufw status verbose`

## Essential software

- [x] git, curl, docker or container runtime, python3-venv
- [x] nginx, postgresql-client, redis-tools
- [x] fail2ban (optional Week 2 stretch)

## Verification commands

```bash
hostnamectl
ip addr show
sudo ufw status
sudo sshd -T | grep -E 'permitrootlogin|passwordauthentication'
systemctl is-active ssh nginx
curl -s http://localhost/health
```

## TaskFlow integration

Server ready for Week 2 `lab-packages-services` stack and Week 11 Ansible automation.