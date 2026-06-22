# DevOps Maturity Assessment — Apex Logistics (Reference)

## Executive summary

Apex Logistics is **Level 2 (Managed)** on a 5-level DevOps maturity scale — processes exist but depend on heroes. DORA metrics are **low** across deployment frequency and time to restore. Transformation must prioritize **automated deploy paths** and **self-service onboarding** to unlock revenue and SOC2 goals without the 4 planned ops hires.

## DORA metrics

| Metric | Current | Target (12 mo) | Evidence |
|--------|---------|----------------|----------|
| Deployment frequency | Monthly | Daily (core APIs) | Big-bang releases; lost $400K deal |
| Lead time for changes | 3–4 weeks | < 1 day | Manual ECS deploys |
| Change failure rate | ~25% | < 15% | Incident rate + rollbacks |
| Time to restore | 6 hours avg | < 1 hour | SLA credits $15K/mo |

## Capability assessment

| Capability | Maturity (1–5) | Gap |
|------------|----------------|-----|
| CI/CD | 2 | No standard pipeline; Jenkins snowflakes |
| IaC | 2 | 9/12 services not in templates |
| Observability | 3 | Datadog present; SLOs missing |
| Security/compliance | 2 | Manual evidence for SOC2 |
| Developer onboarding | 1 | 10-day ramp; $200K contractor cost |
| Culture/collaboration | 3 | Willing leadership; ops overloaded |

## TaskFlow tracking

All remediation epics logged as TaskFlow initiatives with owners — replaces spreadsheet program tracking.

## Key risks if unchanged

- SOC2 remediation failure at 90 days
- Continued SLA credits eroding margin
- Sales misses Q4 weekly-ship commitment