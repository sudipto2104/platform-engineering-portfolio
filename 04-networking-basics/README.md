# Week 4: Networking Fundamentals for Platform Engineers

**Slug:** `networking-fundamentals-platform-engineers`

Week 4 applies networking fundamentals to **TaskFlow** — IP planning, DNS, HTTP/TLS, load balancing, and cloud VPC design (prep for AWS Week 10).

## TaskFlow context

Network designs target the TaskFlow platform across dev, staging, and production. Hands-on stacks use [`../03-version-control-git-github/taskflow-sandbox/`](../03-version-control-git-github/taskflow-sandbox/) and configs under [`taskflow-network/`](./taskflow-network/).

## Labs

| Directory | Focus |
|-----------|--------|
| [`lab-ip-subnetting/`](./lab-ip-subnetting/) | IPv4, CIDR, subnet design for TaskFlow Corp |
| [`lab-dns-fundamentals/`](./lab-dns-fundamentals/) | dig, record types, /etc/hosts, troubleshooting |
| [`lab-http-nginx-tls/`](./lab-http-nginx-tls/) | HTTP methods, headers, Nginx, SSL/TLS |
| [`lab-load-balancing/`](./lab-load-balancing/) | Reverse proxy, LB algorithms, health checks |
| [`lab-network-architecture/`](./lab-network-architecture/) | VPC design (YAML + diagrams) — AWS prep |

Each lab includes `scripts/check.sh` and `scripts/solve.sh`.

## Quick start

```bash
cd lab-ip-subnetting && ./scripts/solve.sh && ./scripts/check.sh
```

## Status

Week 4 complete — 5 labs, TaskFlow network designs, check/solve scripts.