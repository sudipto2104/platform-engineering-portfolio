"""TaskFlow S3 attachment service — boto3 integration."""

from __future__ import annotations

import os
import uuid
from datetime import datetime, timezone

import boto3
from botocore.exceptions import ClientError

BUCKET = os.getenv("TASKFLOW_S3_BUCKET", "taskflow-attachments-dev")
REGION = os.getenv("AWS_REGION", "us-east-1")


def get_s3_client():
    """Use instance profile / env credentials — no hardcoded keys."""
    return boto3.client("s3", region_name=REGION)


def upload_attachment(local_path: str, task_id: int, filename: str) -> dict:
    key = f"tasks/{task_id}/{uuid.uuid4().hex}-{filename}"
    client = get_s3_client()
    client.upload_file(local_path, BUCKET, key, ExtraArgs={"ServerSideEncryption": "AES256"})
    return {
        "bucket": BUCKET,
        "key": key,
        "url": f"s3://{BUCKET}/{key}",
        "uploaded_at": datetime.now(timezone.utc).isoformat(),
    }


def download_attachment(key: str, dest_path: str) -> None:
    get_s3_client().download_file(BUCKET, key, dest_path)


def list_task_attachments(task_id: int, max_keys: int = 50) -> list[str]:
    prefix = f"tasks/{task_id}/"
    client = get_s3_client()
    try:
        resp = client.list_objects_v2(Bucket=BUCKET, Prefix=prefix, MaxKeys=max_keys)
    except ClientError as exc:
        raise RuntimeError(f"S3 list failed: {exc}") from exc
    return [obj["Key"] for obj in resp.get("Contents", [])]


if __name__ == "__main__":
    print(f"TaskFlow S3 module ready — bucket={BUCKET} region={REGION}")