# TaskFlow Production Deploy Guide

Deploy the full Week 10 AWS stack — VPC, EC2, RDS PostgreSQL, ElastiCache Redis, S3, and IAM — with a single `terraform apply`.

## Prerequisites

1. AWS CLI configured with deploy permissions
2. Remote state bootstrap from Lab 2 (`deliverables/bootstrap`)
3. Replace `ACCOUNT_ID` in `environments/production/main.tf` backend block

## Module layout

```
modules/
  vpc/          → 10.30.0.0/16 multi-AZ (public, app, data subnets)
  security/     → web / app / data security groups
  ec2/          → application servers in private app subnets
  rds/          → PostgreSQL Multi-AZ in private data subnets
  elasticache/  → Redis in private data subnets
  s3/           → attachments bucket with versioning
  iam/          → EC2 instance profile (S3 + ECR + SSM)
environments/production/ → composes all modules + S3 remote state
```

## One-command deploy

```bash
cd deliverables/environments/production
cp terraform.tfvars.example terraform.tfvars   # set db_password
terraform init
terraform plan
terraform apply
```

`terraform apply` provisions every resource. No manual console steps.

## Verify outputs

```bash
terraform output rds_endpoint
terraform output redis_endpoint
terraform output attachments_bucket
terraform output app_private_ips
```

## Teardown

```bash
terraform destroy
```

Destroy data-tier resources (RDS, ElastiCache) only after confirming backups.