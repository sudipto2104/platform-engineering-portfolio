# TaskFlow Load Balancer Guide (Reference)

## Architecture

```
Client → Nginx :8095 → upstream pool → taskflow-{1,2,3}:8080
```

## Algorithms

| Algorithm | Config | Best for |
|-----------|--------|----------|
| Round robin | default | Even capacity backends |
| Least connections | `least_conn` | Variable request duration |
| IP hash | `ip_hash` | Sticky sessions without cookies |
| Weighted | `weight=N` | Heterogeneous instance sizes |

## Health checks

Nginx passive checks via `max_fails` + `fail_timeout` — marks backend down after failures.

Active probe pattern (Week 17+):

```nginx
match health_ok {
    status 200;
    header Content-Type ~ "application/json";
}
```

## Sticky sessions

- **ip_hash** — simple, uneven distribution behind NAT
- **cookie** — `sticky` module or Ingress (K8s Week 8)

## Zero-downtime deploy

1. Add new backend with `weight=0` or drain flag
2. Deploy new version to replacement backend
3. Health check passes → increase weight
4. Remove old backend from upstream

## Verification

```bash
for i in $(seq 1 6); do
  curl -s http://localhost:8095/health | python3 -c "import sys,json; print(json.load(sys.stdin)['version'])"
done
# Observe different week4-replica-* versions
```