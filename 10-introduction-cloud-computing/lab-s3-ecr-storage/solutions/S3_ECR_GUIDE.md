# S3 & ECR Guide

## S3 attachments

- Bucket naming: `taskflow-attachments-{env}`
- Key pattern: `tasks/{task_id}/{uuid}-{filename}`
- Use instance profile — `boto3` picks up IAM role automatically on EC2

## ECR migration

```bash
export AWS_ACCOUNT_ID=123456789012
./ecr-migrate.sh
```

Update EC2 `docker-compose.ec2.yml` images:

`123456789012.dkr.ecr.us-east-1.amazonaws.com/taskflow/taskflow-api:v1.0.0`

## IAM

Attach `iam-taskflow-ec2-role.json` as EC2 instance profile — no access keys on disk.