# Week 10: AWS Cloud Computing

**Slug:** `aws-cloud-computing`

Deploy TaskFlow on AWS — EC2 + Docker, S3/ECR storage, and production VPC/IAM architecture.

Builds on Week 4 network designs and Week 7 Docker stack.

## Labs

| Directory | Focus |
|-----------|--------|
| [`lab-ec2-taskflow-deploy/`](./lab-ec2-taskflow-deploy/) | EC2, security groups, Docker Compose, Nginx reverse proxy |
| [`lab-s3-ecr-storage/`](./lab-s3-ecr-storage/) | S3 attachments (boto3), ECR migration, IAM roles |
| [`lab-vpc-iam-security/`](./lab-vpc-iam-security/) | Custom VPC, subnets, NAT/IGW, IAM least privilege |

Each lab includes `scripts/check.sh` and `scripts/solve.sh`.

## Quick start

```bash
cd lab-ec2-taskflow-deploy && ./scripts/solve.sh && ./scripts/check.sh
```

## Status

Week 10 complete — 3 AWS labs, TaskFlow cloud deployment artifacts.