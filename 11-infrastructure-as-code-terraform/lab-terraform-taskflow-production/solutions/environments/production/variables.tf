variable "aws_region" {
  type    = string
  default = "us-east-1"
}

variable "project" {
  type    = string
  default = "taskflow"
}

variable "environment" {
  type    = string
  default = "production"
}

variable "vpc_cidr" {
  type    = string
  default = "10.30.0.0/16"

  validation {
    condition     = can(cidrhost(var.vpc_cidr, 0))
    error_message = "vpc_cidr must be a valid CIDR block."
  }
}

variable "app_count" {
  type    = number
  default = 2
}

variable "instance_type" {
  type    = string
  default = "t3.medium"
}

variable "db_password" {
  type      = string
  sensitive = true
}