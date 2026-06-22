locals {
  common_tags = {
    Project     = var.project
    Environment = var.environment
    ManagedBy   = "terraform"
    Week        = "11-lab1"
  }
}

resource "aws_vpc" "taskflow" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  tags                 = merge(local.common_tags, { Name = "${var.project}-vpc" })
}

resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.taskflow.id
  cidr_block              = cidrsubnet(var.vpc_cidr, 8, 1)
  map_public_ip_on_launch = true
  availability_zone       = data.aws_availability_zones.available.names[0]
  tags                    = merge(local.common_tags, { Name = "${var.project}-public", Tier = "web" })
}

resource "aws_s3_bucket" "taskflow_lab" {
  bucket = "${var.project}-${var.environment}-lab-${data.aws_caller_identity.current.account_id}"
  tags   = local.common_tags
}

resource "aws_s3_bucket_versioning" "taskflow_lab" {
  bucket = aws_s3_bucket.taskflow_lab.id
  versioning_configuration { status = "Enabled" }
}

data "aws_availability_zones" "available" {
  state = "available"
}

data "aws_caller_identity" "current" {}