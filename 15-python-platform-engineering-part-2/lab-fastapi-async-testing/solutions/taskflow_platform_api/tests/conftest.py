"""Pytest fixtures for TaskFlow Platform API tests."""

from __future__ import annotations

import pytest
from fastapi.testclient import TestClient

from taskflow_platform_api.main import app


@pytest.fixture
def client() -> TestClient:
    return TestClient(app)