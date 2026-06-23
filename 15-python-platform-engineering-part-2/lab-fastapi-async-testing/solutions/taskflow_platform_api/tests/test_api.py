"""pytest test suite for TaskFlow Platform API."""

from __future__ import annotations

import time

from fastapi.testclient import TestClient


def test_health_endpoint(client: TestClient):
    resp = client.get("/health")
    assert resp.status_code == 200
    assert resp.json()["status"] == "healthy"


def test_trigger_deployment_returns_job_id(client: TestClient):
    resp = client.post(
        "/api/v1/deployments",
        json={"service_name": "taskflow-api", "environment": "dev"},
    )
    assert resp.status_code == 202
    data = resp.json()
    assert "job_id" in data
    assert data["status"] == "queued"


def test_deployment_job_completes(client: TestClient):
    resp = client.post(
        "/api/v1/deployments",
        json={"service_name": "taskflow-frontend", "environment": "staging"},
    )
    job_id = resp.json()["job_id"]

    # Poll until background task completes
    for _ in range(20):
        status_resp = client.get(f"/api/v1/deployments/{job_id}")
        if status_resp.status_code == 200 and status_resp.json().get("status") == "completed":
            break
        time.sleep(0.05)
    else:
        raise AssertionError("Deployment job did not complete in time")

    assert status_resp.json()["service"] == "taskflow-frontend"


def test_deployment_job_not_found(client: TestClient):
    resp = client.get("/api/v1/deployments/nonexistent")
    assert resp.status_code == 404


def test_external_health_check(client: TestClient):
    resp = client.get("/api/v1/deployments/health/external")
    assert resp.status_code == 200
    data = resp.json()
    assert "healthy" in data