# Lab: DevOps Maturity Analysis

Analyze a real-world scenario, identify DevOps anti-patterns, assess maturity with DORA metrics, and create an improvement plan for **Meridian Retail** — a company preparing to adopt TaskFlow.

## Scenario

Read the full case study:

```bash
cat scenario/MERIDIAN_RETAIL.md
```

## Your deliverables

Complete these files in `deliverables/`:

| File | Purpose |
|------|---------|
| `ANTI_PATTERNS.md` | DevOps anti-patterns you identify |
| `DORA_ASSESSMENT.md` | DORA metrics assessment with evidence |
| `IMPROVEMENT_PLAN.md` | Prioritized recommendations and business value |

Use `templates/` as starting points. Reference the sample solution in `solutions/` only after attempting your own analysis.

## DORA metrics (quick reference)

| Metric | What it measures | Elite benchmark |
|--------|------------------|-----------------|
| Deployment frequency | How often code reaches production | On demand (multiple/day) |
| Lead time for changes | Commit → production | Less than one hour |
| Change failure rate | Deployments causing failure | 0–15% |
| Time to restore | Recovery from incidents | Less than one hour |

## Verify

```bash
./scripts/check.sh
```

## Solution

```bash
./scripts/solve.sh
```

Populates `deliverables/` with a reference analysis you can compare against your work.