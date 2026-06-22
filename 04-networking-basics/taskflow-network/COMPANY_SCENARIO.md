# TaskFlow Corp — Network Design Scenario

**TaskFlow Corp** deploys the TaskFlow platform in three environments:

| Environment | Users | Tier |
|-------------|-------|------|
| dev | Engineers | Single AZ acceptable |
| staging | QA + demos | Multi-AZ preferred |
| production | Customers | Multi-AZ required |

## Application tiers

1. **Web** — Nginx ingress / load balancer (public subnets)
2. **Application** — TaskFlow API containers (private subnets)
3. **Database** — PostgreSQL, Redis (private isolated subnets)

## Addressing constraints

- Use **RFC 1918** private space only
- No overlapping CIDRs between environments (for future VPN/peering)
- Reserve 20% headroom per subnet for autoscaling
- Document every allocation in lab deliverables