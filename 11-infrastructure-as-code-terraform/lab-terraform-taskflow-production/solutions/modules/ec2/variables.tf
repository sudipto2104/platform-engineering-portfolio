variable "project" { type = string }
variable "environment" { type = string }
variable "subnet_ids" { type = list(string) }
variable "instance_type" { type = string default = "t3.medium" }
variable "instance_profile_name" { type = string }
variable "security_group_ids" { type = list(string) }
variable "app_count" { type = number default = 2 }