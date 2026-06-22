data "aws_caller_identity" "current" {}

resource "aws_iam_role" "ec2" {
  name = "${var.project}-${var.environment}-ec2-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect    = "Allow"
      Principal = { Service = "ec2.amazonaws.com" }
      Action    = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_role_policy" "ec2" {
  name = "${var.project}-${var.environment}-ec2-policy"
  role = aws_iam_role.ec2.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = "TaskFlowS3Attachments"
        Effect = "Allow"
        Action = ["s3:PutObject", "s3:GetObject", "s3:ListBucket", "s3:DeleteObject"]
        Resource = [
          var.attachments_bucket_arn,
          "${var.attachments_bucket_arn}/*"
        ]
      },
      {
        Sid    = "TaskFlowECRPull"
        Effect = "Allow"
        Action = [
          "ecr:GetAuthorizationToken",
          "ecr:BatchCheckLayerAvailability",
          "ecr:GetDownloadUrlForLayer",
          "ecr:BatchGetImage"
        ]
        Resource = "*"
      },
      {
        Sid    = "TaskFlowSSMSession"
        Effect = "Allow"
        Action = [
          "ssm:UpdateInstanceInformation",
          "ssmmessages:CreateControlChannel",
          "ssmmessages:CreateDataChannel",
          "ssmmessages:OpenControlChannel",
          "ssmmessages:OpenDataChannel"
        ]
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_instance_profile" "ec2" {
  name = "${var.project}-${var.environment}-ec2-profile"
  role = aws_iam_role.ec2.name
}