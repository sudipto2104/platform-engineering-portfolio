variable "aws_region" {
  type        = string
  description = "AWS region for TaskFlow lab resources"
  default     = "us-east-1"

  validation {
    condition     = can(regex("^us-|eu-|ap-", var.aws_region))
    error_message = "aws_region must be a valid AWS region identifier."
  }
}

variable "project" {
  type        = string
  description = "Project name used in resource tags"
  default     = "taskflow"
}

variable "environment" {
  type        = string
  description = "Deployment environment"
  default     = "lab"

  validation {
    condition     = contains(["lab", "dev", "staging", "production"], var.environment)
    error_message = "environment must be lab, dev, staging, or production."
  }
}

variable "vpc_cidr" {
  type    = string
  default = "10.30.0.0/16"
}