# Lab: Boto3 AWS Automation

Master the AWS SDK for Python (Boto3) by automating EC2, S3, CloudWatch, and Lambda operations for the TaskFlow platform.

## What you build

- `taskflow_aws/` package with modular service clients
- EC2 instance discovery and lifecycle (describe, start, stop) by TaskFlow tags
- S3 attachment operations (extends Week 10 patterns)
- CloudWatch custom metrics and alarms for TaskFlow health
- Lambda invocation for automated health-check workflows

## Quick start

```bash
./scripts/solve.sh && ./scripts/check.sh
pip install -r deliverables/requirements.txt
python -m taskflow_aws --help
```

See `deliverables/BOTO3_AWS_GUIDE.md` after solve.