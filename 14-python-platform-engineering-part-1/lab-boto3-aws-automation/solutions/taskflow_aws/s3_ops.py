"""S3 automation for TaskFlow attachments — extends Week 10 patterns."""

from __future__ import annotations

import uuid
from datetime import datetime, timezone
from typing import Any

import boto3
from botocore.exceptions import ClientError

from .config import CONFIG


def get_s3_client():
    return boto3.client("s3", region_name=CONFIG.region)


def upload_task_attachment(local_path: str, task_id: int, filename: str) -> dict[str, Any]:
    key = f"tasks/{task_id}/{uuid.uuid4().hex}-{filename}"
    client = get_s3_client()
    try:
        client.upload_file(
            local_path,
            CONFIG.s3_bucket,
            key,
            ExtraArgs={"ServerSideEncryption": "AES256"},
        )
    except ClientError as exc:
        raise RuntimeError(f"S3 upload failed: {exc}") from exc
    return {
        "bucket": CONFIG.s3_bucket,
        "key": key,
        "url": f"s3://{CONFIG.s3_bucket}/{key}",
        "uploaded_at": datetime.now(timezone.utc).isoformat(),
    }


def list_task_attachments(task_id: int, max_keys: int = 50) -> list[str]:
    prefix = f"tasks/{task_id}/"
    client = get_s3_client()
    try:
        resp = client.list_objects_v2(
            Bucket=CONFIG.s3_bucket, Prefix=prefix, MaxKeys=max_keys
        )
    except ClientError as exc:
        raise RuntimeError(f"S3 list failed: {exc}") from exc
    return [obj["Key"] for obj in resp.get("Contents", [])]


def ensure_taskflow_bucket_exists() -> bool:
    client = get_s3_client()
    try:
        client.head_bucket(Bucket=CONFIG.s3_bucket)
        return True
    except ClientError:
        client.create_bucket(Bucket=CONFIG.s3_bucket)
        return True