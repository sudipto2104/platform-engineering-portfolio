output "vpc_id" {
  value = aws_vpc.taskflow.id
}

output "public_subnet_ids" {
  value = aws_subnet.public[*].id
}

output "private_app_subnet_ids" {
  value = aws_subnet.private_app[*].id
}

output "private_data_subnet_ids" {
  value = aws_subnet.private_data[*].id
}

output "web_security_group_id" {
  value = aws_security_group.web.id
}

output "ec2_instance_profile_arn" {
  value = aws_iam_instance_profile.taskflow_ec2.arn
}