# TaskFlow Corp Subnet Design (Reference)

## VPC allocations (non-overlapping)

| Environment | VPC CIDR | Rationale |
|-------------|----------|-----------|
| dev | `10.10.0.0/16` | Small footprint, /16 enough for 3 tiers |
| staging | `10.20.0.0/16` | Mirrors prod topology at smaller scale |
| production | `10.30.0.0/16` | Largest headroom for HA |

## Staging subnet breakdown (`10.20.0.0/16`)

| Subnet | CIDR | Tier | AZ | Usable hosts |
|--------|------|------|-----|--------------|
| public-web-a | 10.20.1.0/24 | Web / LB | a | 254 |
| public-web-b | 10.20.2.0/24 | Web / LB | b | 254 |
| private-app-a | 10.20.10.0/23 | TaskFlow API | a | 510 |
| private-app-b | 10.20.12.0/23 | TaskFlow API | b | 510 |
| private-data-a | 10.20.20.0/24 | PostgreSQL | a | 254 |
| private-data-b | 10.20.21.0/24 | Redis replica | b | 254 |

## Key calculations

```
10.20.10.0/23
  Network:   10.20.10.0
  Broadcast: 10.20.11.255
  Mask:      255.255.254.0
```

## Best practices applied

- /24 for web and data — predictable, enough for LB + NAT
- /23 for app tier — room for K8s node scaling (Week 8+)
- No subnet shares broadcast domain across tiers
- 20% reserved capacity documented per tier

## Verification commands

```bash
python3 scripts/subnet_calculator.py 10.20.10.0/23
ping -c 1 10.20.10.1    # gateway (when deployed)
```