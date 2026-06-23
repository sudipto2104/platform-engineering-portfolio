"""Custom Prometheus exporter for TaskFlow API metrics."""

from __future__ import annotations

import os
import time
from http.server import BaseHTTPRequestHandler, HTTPServer

import requests
from prometheus_client import Counter, Gauge, Histogram, generate_latest

API_URL = os.getenv("TASKFLOW_API_URL", "http://taskflow-api:8080")

REQUEST_COUNT = Counter(
    "taskflow_http_requests_total",
    "Total HTTP requests proxied from TaskFlow API",
    ["method", "endpoint", "status"],
)
REQUEST_LATENCY = Histogram(
    "taskflow_http_request_duration_seconds",
    "HTTP request latency in seconds",
    ["endpoint"],
    buckets=(0.01, 0.05, 0.1, 0.25, 0.5, 1.0, 2.5),
)
TASK_COUNT = Gauge("taskflow_tasks_total", "Current number of tasks")
API_HEALTHY = Gauge("taskflow_api_healthy", "1 if API health check passes")
ACTIVE_USERS = Gauge("taskflow_active_users", "Estimated active users")


def collect_metrics() -> None:
    start = time.perf_counter()
    try:
        health = requests.get(f"{API_URL}/health", timeout=5)
        API_HEALTHY.set(1 if health.ok else 0)
        REQUEST_COUNT.labels("GET", "/health", str(health.status_code)).inc()
    except requests.RequestException:
        API_HEALTHY.set(0)
        REQUEST_COUNT.labels("GET", "/health", "error").inc()

    elapsed = time.perf_counter() - start
    REQUEST_LATENCY.labels("/health").observe(elapsed)

    try:
        resp = requests.get(f"{API_URL}/api/tasks", timeout=5)
        if resp.ok:
            data = resp.json()
            count = data.get("count", len(data.get("tasks", [])))
            TASK_COUNT.set(count)
            ACTIVE_USERS.set(max(1, count // 2))
            REQUEST_COUNT.labels("GET", "/api/tasks", str(resp.status_code)).inc()
        REQUEST_LATENCY.labels("/api/tasks").observe(time.perf_counter() - start)
    except requests.RequestException:
        REQUEST_COUNT.labels("GET", "/api/tasks", "error").inc()


class MetricsHandler(BaseHTTPRequestHandler):
    def do_GET(self):
        if self.path == "/metrics":
            collect_metrics()
            self.send_response(200)
            self.send_header("Content-Type", "text/plain; version=0.0.4")
            self.end_headers()
            self.wfile.write(generate_latest())
        elif self.path == "/health":
            self.send_response(200)
            self.end_headers()
            self.wfile.write(b"ok")
        else:
            self.send_response(404)
            self.end_headers()

    def log_message(self, format, *args):
        pass


def main():
    port = int(os.getenv("EXPORTER_PORT", "9100"))
    server = HTTPServer(("0.0.0.0", port), MetricsHandler)
    print(f"TaskFlow exporter listening on :{port}")
    server.serve_forever()


if __name__ == "__main__":
    main()