# Lab: TaskFlow Production Infrastructure (Capstone)

One `terraform apply` provisions VPC, EC2, RDS PostgreSQL, ElastiCache Redis, S3, and IAM — the full Week 10 AWS stack as composable Terraform modules.

## What you build

| Module | Resources |
|--------|-----------|
| `vpc` | Multi-AZ public, app, and data subnets (`10.30.0.0/16`) |
| `security` | Web, app, and data security groups |
| `ec2` | TaskFlow app servers in private app subnets |
| `rds` | PostgreSQL Multi-AZ in private data subnets |
| `elasticache` | Redis cluster in private data subnets |
| `s3` | Versioned attachments bucket |
| `iam` | EC2 instance profile (S3, ECR, SSM) |

## Quick start

```bash
./scripts/solve.sh && ./scripts/check.sh
cd deliverables/environments/production && terraform init && terraform plan
```

See `deliverables/PRODUCTION_DEPLOY_GUIDE.md` after solve.