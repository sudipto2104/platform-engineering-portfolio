resource "aws_iam_role" "taskflow_ec2" {
  name = "${var.project}-ec2-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect    = "Allow"
      Principal = { Service = "ec2.amazonaws.com" }
      Action    = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_role_policy" "taskflow_s3_ecr" {
  name = "${var.project}-s3-ecr-policy"
  role = aws_iam_role.taskflow_ec2.id
  policy = file("${path.module}/../iam/taskflow-ec2-policy.json")
}

resource "aws_iam_instance_profile" "taskflow_ec2" {
  name = "${var.project}-ec2-profile"
  role = aws_iam_role.taskflow_ec2.name
}

resource "aws_iam_role" "taskflow_deployer" {
  name = "${var.project}-deployer-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect    = "Allow"
      Principal = { AWS = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:root" }
      Action    = "sts:AssumeRole"
      Condition = {
        StringEquals = { "aws:PrincipalTag/team" = "platform" }
      }
    }]
  })
}

resource "aws_iam_role_policy" "deployer_ecr" {
  name = "${var.project}-deployer-ecr"
  role = aws_iam_role.taskflow_deployer.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Sid      = "ECRPushPull"
      Effect   = "Allow"
      Action   = ["ecr:*"]
      Resource = "arn:aws:ecr:${var.aws_region}:${data.aws_caller_identity.current.account_id}:repository/taskflow/*"
    }]
  })
}

data "aws_caller_identity" "current" {}