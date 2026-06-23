# Boto3 AWS Automation Guide — TaskFlow

## Overview

Production-ready Boto3 patterns for TaskFlow platform engineering. Extends Week 10 S3 work with EC2 lifecycle, CloudWatch observability, and Lambda workflows.

## Module layout

| Module | AWS Service | Operations |
|--------|-------------|------------|
| `config.py` | — | Region, tags, bucket names from env |
| `ec2_ops.py` | EC2 | `describe_instances`, `start_instances`, `stop_instances` |
| `s3_ops.py` | S3 | `upload_file`, `list_objects_v2`, `head_bucket` |
| `cloudwatch_ops.py` | CloudWatch | `put_metric_data`, `put_metric_alarm` |
| `lambda_ops.py` | Lambda | `list_functions`, `invoke` |

## Credentials (production pattern)

Never hardcode keys. Use one of:

```bash
export AWS_REGION=us-east-1
aws configure                    # local dev
# EC2 instance profile           # production (Week 10 IAM role)
# IRSA / OIDC                    # EKS (Week 9)
```

## EC2 — TaskFlow servers

Instances are discovered by tag `Project=TaskFlow` (from Week 10 EC2 lab).

```bash
cd deliverables
python -m taskflow_aws ec2-list
```

```python
from taskflow_aws.ec2_ops import describe_taskflow_instances, start_taskflow_instances

instances = describe_taskflow_instances()
start_taskflow_instances([instances[0]["instance_id"]])
```

## S3 — TaskFlow attachments

```python
from taskflow_aws.s3_ops import upload_task_attachment, list_task_attachments

meta = upload_task_attachment("/tmp/report.pdf", task_id=42, filename="report.pdf")
keys = list_task_attachments(42)
```

## CloudWatch — Platform metrics

```python
from taskflow_aws.cloudwatch_ops import publish_taskflow_health_metric, create_taskflow_health_alarm

publish_taskflow_health_metric(healthy=True, task_count=12, environment="staging")
create_taskflow_health_alarm(environment="staging")
```

## Lambda — Health-check automation

```python
from taskflow_aws.lambda_ops import invoke_health_check, list_taskflow_functions

functions = list_taskflow_functions()
result = invoke_health_check({"target": "http://taskflow-api:8080/health"})
```

## Error handling

All modules catch `botocore.exceptions.ClientError` and raise `RuntimeError` with context — wrap in retry logic for production pipelines.

## Verify

```bash
./scripts/check.sh
python -m py_compile taskflow_aws/*.py
```