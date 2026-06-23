"""CLI entrypoint: python -m taskflow_aws"""

from __future__ import annotations

import argparse
import json

from . import cloudwatch_ops, ec2_ops, lambda_ops, s3_ops


def main() -> None:
    parser = argparse.ArgumentParser(description="TaskFlow AWS automation toolkit")
    sub = parser.add_subparsers(dest="command", required=True)

    sub.add_parser("ec2-list", help="List TaskFlow EC2 instances")
    sub.add_parser("s3-bucket-check", help="Ensure TaskFlow S3 bucket exists")
    sub.add_parser("lambda-list", help="List TaskFlow Lambda functions")

    cw = sub.add_parser("cw-publish", help="Publish TaskFlow health metrics")
    cw.add_argument("--healthy", action="store_true", default=True)
    cw.add_argument("--tasks", type=int, default=0)

    args = parser.parse_args()

    if args.command == "ec2-list":
        print(json.dumps(ec2_ops.describe_taskflow_instances(), indent=2))
    elif args.command == "s3-bucket-check":
        print(json.dumps({"exists": s3_ops.ensure_taskflow_bucket_exists()}))
    elif args.command == "lambda-list":
        print(json.dumps(lambda_ops.list_taskflow_functions(), indent=2))
    elif args.command == "cw-publish":
        print(json.dumps(
            cloudwatch_ops.publish_taskflow_health_metric(args.healthy, args.tasks),
            indent=2,
        ))


if __name__ == "__main__":
    main()