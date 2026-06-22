# VPC & IAM Architecture Guide

## Network zones (10.30.0.0/16)

| Tier | Subnets | Route | SG |
|------|---------|-------|-----|
| Web | public /24 | IGW | 443 from internet |
| App | private /22 | NAT | 8080 from web SG |
| Data | private /24 | NAT (egress only) | 5432/6379 from app SG |

## Deploy

```bash
cd deliverables/terraform
terraform init
terraform plan -var="environment=production"
terraform apply
```

## IAM least privilege

- **EC2 instance profile** — S3 attachments + ECR pull only
- **Deployer role** — ECR push to `taskflow/*` repos, condition on `platform` tag
- Test with `iam-policy-tests.sh` + AWS Policy Simulator

## Week 4 alignment

Implements the Week 4 `production.yaml` VPC design in Terraform.