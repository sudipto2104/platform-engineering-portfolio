output "vpc_id" {
  description = "TaskFlow lab VPC identifier"
  value       = aws_vpc.taskflow.id
}

output "public_subnet_id" {
  description = "Public subnet for web tier"
  value       = aws_subnet.public.id
}

output "s3_bucket_name" {
  description = "TaskFlow lab S3 bucket"
  value       = aws_s3_bucket.taskflow_lab.bucket
}

output "account_id" {
  description = "AWS account ID"
  value       = data.aws_caller_identity.current.account_id
}