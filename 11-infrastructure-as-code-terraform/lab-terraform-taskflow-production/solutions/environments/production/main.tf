terraform {
  required_version = ">= 1.5.0"
  backend "s3" {
    bucket         = "taskflow-terraform-state-ACCOUNT_ID"
    key            = "production/taskflow/infrastructure/terraform.tfstate"
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

module "security" {
  source      = "../../modules/security"
  project     = var.project
  environment = var.environment
  vpc_id      = module.vpc.vpc_id
  vpc_cidr    = var.vpc_cidr
}

module "attachments" {
  source      = "../../modules/s3"
  project     = var.project
  environment = var.environment
}

module "iam" {
  source               = "../../modules/iam"
  project              = var.project
  environment          = var.environment
  aws_region           = var.aws_region
  attachments_bucket_arn = module.attachments.bucket_arn
}

module "app" {
  source                = "../../modules/ec2"
  project               = var.project
  environment           = var.environment
  subnet_ids            = module.vpc.private_app_subnet_ids
  security_group_ids    = [module.security.app_sg_id]
  instance_profile_name = module.iam.instance_profile_name
  app_count             = var.app_count
  instance_type         = var.instance_type
}

module "database" {
  source             = "../../modules/rds"
  project            = var.project
  environment        = var.environment
  vpc_id             = module.vpc.vpc_id
  subnet_ids         = module.vpc.private_data_subnet_ids
  security_group_ids = [module.security.data_sg_id]
  db_password        = var.db_password
}

module "cache" {
  source             = "../../modules/elasticache"
  project            = var.project
  environment        = var.environment
  subnet_ids         = module.vpc.private_data_subnet_ids
  security_group_ids = [module.security.data_sg_id]
}

output "vpc_id" { value = module.vpc.vpc_id }
output "app_private_ips" { value = module.app.private_ips }
output "rds_endpoint" { value = module.database.endpoint }
output "redis_endpoint" { value = module.cache.endpoint }
output "attachments_bucket" { value = module.attachments.bucket_name }
output "ec2_instance_profile" { value = module.iam.instance_profile_name }