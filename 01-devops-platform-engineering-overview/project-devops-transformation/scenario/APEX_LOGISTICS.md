# Case Study: Apex Logistics

## Company profile

**Apex Logistics** is a B2B shipping API company ($28M ARR, 95 engineers, 12 microservices). Customers integrate via REST APIs; uptime SLAs drive contract renewals.

The board approved a **12-month DevOps transformation** budget of $850K. You are the lead consultant. **TaskFlow** will track every initiative.

## Pain summary

| Area | Symptom | Business impact |
|------|---------|-----------------|
| Releases | Monthly big-bang deploys | Lost $400K deal due to delayed API feature |
| Incidents | 6-hour average recovery | SLA credits $15K/month |
| Onboarding | 10-day engineer ramp | Contractor spend $200K/year |
| Compliance | Manual audit evidence | Failed SOC2 observation — remediate in 90 days |
| Toil | 35% of ops time on repetitive tickets | Cannot scale without 4 more hires |

## Current toolchain

- GitHub, Jenkins, Ansible (partial), AWS ECS, PagerDuty, Datadog
- No IaC standard; 3 "golden" ECS services, 9 snowflakes
- Security scans manual before prod

## Stakeholders

- **CEO:** ROI within 2 quarters
- **CTO:** DORA improvement without hero culture
- **CFO:** Cap headcount; fund automation
- **VP Sales:** API features shipped weekly by Q4

## Your capstone deliverables

1. **Maturity assessment** — people, process, technology (use DORA + capabilities model).
2. **Transformation strategy** — 3 phases over 12 months with TaskFlow epics.
3. **Automation prototypes** — scripts that demonstrate quick wins (deploy readiness, onboarding audit, toil metrics).
4. **Business case** — costs, savings, ROI, risks for the board.