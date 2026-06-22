# One-time bootstrap — create state bucket and lock table (apply locally first)
terraform {
  required_version = ">= 1.5.0"
  required_providers {
    aws = { source = "hashicorp/aws", version = "~> 5.0" }
  }
}

provider "aws" {
  region = var.aws_region
}

variable "aws_region" { default = "us-east-1" }
variable "project" { default = "taskflow" }

resource "aws_s3_bucket" "terraform_state" {
  bucket = "${var.project}-terraform-state-${data.aws_caller_identity.current.account_id}"
  tags   = { Name = "terraform-state", Project = var.project }
}

resource "aws_s3_bucket_versioning" "state" {
  bucket = aws_s3_bucket.terraform_state.id
  versioning_configuration { status = "Enabled" }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "state" {
  bucket = aws_s3_bucket.terraform_state.id
  rule {
    apply_server_side_encryption_by_default { sse_algorithm = "AES256" }
  }
}

resource "aws_dynamodb_table" "terraform_locks" {
  name         = "${var.project}-terraform-locks"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"
  attribute { name = "LockID" type = "S" }
  tags = { Name = "terraform-locks", Project = var.project }
}

data "aws_caller_identity" "current" {}

output "state_bucket" { value = aws_s3_bucket.terraform_state.bucket }
output "lock_table" { value = aws_dynamodb_table.terraform_locks.name }