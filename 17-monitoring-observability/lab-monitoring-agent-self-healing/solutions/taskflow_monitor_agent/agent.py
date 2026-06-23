"""TaskFlow self-healing monitoring agent."""

from __future__ import annotations

import argparse
import logging
import time

from .metrics import check_api_health, start_metrics_server
from .remediation import execute_remediation
from .thresholds import evaluate_thresholds

logging.basicConfig(level=logging.INFO, format="%(asctime)s %(levelname)s %(message)s")
logger = logging.getLogger(__name__)


def run_agent(interval: int = 30, dry_run: bool = False, metrics_port: int = 9101) -> None:
    start_metrics_server(metrics_port)
    logger.info("TaskFlow monitoring agent started (interval=%ds, dry_run=%s)", interval, dry_run)

    consecutive_failures = 0

    while True:
        result = check_api_health()
        healthy = result.get("healthy", False)
        consecutive_failures = 0 if healthy else consecutive_failures + 1

        metrics = {
            "healthy": 1.0 if healthy else 0.0,
            "latency": result.get("latency", 0.0),
            "consecutive_failures": float(consecutive_failures),
        }

        alerts = evaluate_thresholds(metrics)
        for alert in alerts:
            logger.warning("Threshold breached: %s (severity=%s)", alert["name"], alert["severity"])
            outcome = execute_remediation(alert, dry_run=dry_run)
            logger.info("Self-healing remediation: %s", outcome)

        time.sleep(interval)


def main():
    parser = argparse.ArgumentParser(description="TaskFlow self-healing monitoring agent")
    parser.add_argument("--interval", type=int, default=30)
    parser.add_argument("--dry-run", action="store_true")
    parser.add_argument("--metrics-port", type=int, default=9101)
    args = parser.parse_args()
    run_agent(interval=args.interval, dry_run=args.dry_run, metrics_port=args.metrics_port)


if __name__ == "__main__":
    main()