# Remote State & Modules Guide

## Bootstrap (once per account)

```bash
cd deliverables/bootstrap
terraform init && terraform apply
# Note bucket + DynamoDB table names for backend config
```

## Backend configuration

```hcl
backend "s3" {
  bucket         = "taskflow-terraform-state-<account_id>"
  key            = "dev/taskflow/network/terraform.tfstate"
  dynamodb_table = "taskflow-terraform-locks"
  encrypt        = true
}
```

## Module composition

```
modules/vpc/     → network foundation
modules/s3/      → attachment storage
environments/dev → wires modules + remote state
```

Replace `ACCOUNT_ID` in `environments/dev/main.tf` after bootstrap.