# Terraform Basics Guide

## Workflow

```bash
cd deliverables/terraform
terraform init
terraform fmt -recursive
terraform validate
terraform plan -var-file=terraform.tfvars.example
terraform apply -var-file=terraform.tfvars.example
```

## HCL concepts in this lab

| Concept | File | Example |
|---------|------|---------|
| Variables | `variables.tf` | `var.aws_region` with validation |
| Locals | `main.tf` | `local.common_tags` |
| Resources | `main.tf` | `aws_vpc`, `aws_s3_bucket` |
| Data sources | `main.tf` | `data.aws_caller_identity` |
| Outputs | `outputs.tf` | `vpc_id`, `s3_bucket_name` |

## Destroy

```bash
terraform destroy -var-file=terraform.tfvars.example
```