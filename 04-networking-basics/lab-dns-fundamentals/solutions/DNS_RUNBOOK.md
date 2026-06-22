# TaskFlow DNS Runbook (Reference)

## Record types

| Type | Purpose | TaskFlow example |
|------|---------|------------------|
| A | IPv4 address | `api.taskflow.local → 10.20.10.10` |
| AAAA | IPv6 | (future) |
| CNAME | Alias | `health → api` |
| MX | Mail | `mail.taskflow.local` |
| TXT | Verification | ACME, SPF |
| NS | Nameserver | `ns1.taskflow.local` |

## Query commands

```bash
dig api.taskflow.local A +short
dig taskflow.local MX
dig health.taskflow.local CNAME
dig taskflow.local TXT
dig @8.8.8.8 google.com   # external resolver
dig +trace taskflow.local # resolution hierarchy (lab zone local)
host api.taskflow.local
nslookup api.taskflow.local
```

## Local resolution

`/etc/hosts` overrides DNS for dev — see `workspace/hosts.snippet`.

## TTL & caching

- Zone default TTL: **300s** (5 min) for fast failover in staging
- Production API: 60–120s behind load balancer
- Lower TTL before migrations

## Troubleshooting

1. `dig +short` — expected IP?
2. `dig +trace` — which NS fails?
3. Check `/etc/hosts` overrides
4. `scutil --dns` (macOS) or `systemd-resolve --status` (Linux)

## Kubernetes service discovery (preview)

| Pattern | DNS name |
|---------|----------|
| ClusterIP Service | `taskflow.default.svc.cluster.local` |
| Headless | `pod.taskflow-headless.default.svc.cluster.local` |
| ExternalName | CNAME to external API |