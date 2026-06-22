# TaskFlow Terraform (Week 11)

| Layer | Module | AWS services |
|-------|--------|--------------|
| Network | `modules/vpc` | VPC, subnets, IGW, NAT, SGs |
| Compute | `modules/ec2` | App instances, user-data |
| Data | `modules/rds` | PostgreSQL Multi-AZ |
| Cache | `modules/elasticache` | Redis cluster |
| Storage | `modules/s3` | Attachment buckets |
| Security | `modules/iam` | Instance profiles, policies |

State: S3 `taskflow-terraform-state-{account}` + DynamoDB `taskflow-terraform-locks`.