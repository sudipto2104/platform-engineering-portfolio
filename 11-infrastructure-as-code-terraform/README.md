# Week 11: Terraform Infrastructure as Code

**Slug:** `terraform-infrastructure-as-code`

Automate TaskFlow on AWS with Terraform — HCL fundamentals, remote state + modules, and full production stack.

Builds on [`../10-introduction-cloud-computing/`](../10-introduction-cloud-computing/).

## Labs

| Directory | Focus |
|-----------|--------|
| [`lab-terraform-hcl-fundamentals/`](./lab-terraform-hcl-fundamentals/) | HCL, variables, outputs, init/plan/apply, validation |
| [`lab-terraform-remote-state-modules/`](./lab-terraform-remote-state-modules/) | S3 backend, DynamoDB locking, reusable modules |
| [`lab-terraform-taskflow-production/`](./lab-terraform-taskflow-production/) | Capstone — VPC, EC2, RDS, ElastiCache, S3, IAM |

Each lab includes `scripts/check.sh` and `scripts/solve.sh`.

## Quick start

```bash
cd lab-terraform-hcl-fundamentals && ./scripts/solve.sh && ./scripts/check.sh
```

## Status

Week 11 complete — 3 Terraform labs, TaskFlow IaC modules.