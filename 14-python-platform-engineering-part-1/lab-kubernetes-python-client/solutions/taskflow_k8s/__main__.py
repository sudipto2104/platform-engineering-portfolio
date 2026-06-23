"""CLI entrypoint: python -m taskflow_k8s"""

from __future__ import annotations

import argparse
import json

from .workflow import deploy_taskflow_stack, get_taskflow_stack_status, scale_taskflow_api


def main() -> None:
    parser = argparse.ArgumentParser(description="TaskFlow Kubernetes automation")
    sub = parser.add_subparsers(dest="command", required=True)

    deploy = sub.add_parser("deploy", help="Deploy TaskFlow stack")
    deploy.add_argument("--namespace", default="taskflow")

    status = sub.add_parser("status", help="Get stack status")
    status.add_argument("--namespace", default="taskflow")

    scale = sub.add_parser("scale", help="Scale taskflow-api deployment")
    scale.add_argument("replicas", type=int)
    scale.add_argument("--namespace", default="taskflow")

    args = parser.parse_args()

    if args.command == "deploy":
        print(json.dumps(deploy_taskflow_stack(args.namespace), indent=2))
    elif args.command == "status":
        print(json.dumps(get_taskflow_stack_status(args.namespace), indent=2))
    elif args.command == "scale":
        print(json.dumps(scale_taskflow_api(args.replicas, args.namespace), indent=2))


if __name__ == "__main__":
    main()