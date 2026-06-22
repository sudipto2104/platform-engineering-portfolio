terraform {
  required_version = ">= 1.5.0"
  backend "s3" {
    bucket         = "taskflow-terraform-state-ACCOUNT_ID"
    key            = "dev/taskflow/network/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "taskflow-terraform-locks"
    encrypt        = true
  }
  required_providers {
    aws = { source = "hashicorp/aws", version = "~> 5.0" }
  }
}

provider "aws" {
  region = var.aws_region
}

module "vpc" {
  source      = "../../modules/vpc"
  project     = var.project
  environment = var.environment
  vpc_cidr    = var.vpc_cidr
}

module "attachments" {
  source      = "../../modules/s3"
  project     = var.project
  environment = var.environment
}

output "vpc_id" { value = module.vpc.vpc_id }
output "attachments_bucket" { value = module.attachments.bucket_name }