from datetime import datetime, timezone
import os

from flask import Blueprint, jsonify

health_bp = Blueprint("health", __name__)


@health_bp.get("/health")
def health():
    return jsonify(
        {
            "status": "healthy",
            "service": "taskflow-api",
            "version": os.getenv("TASKFLOW_VERSION", "week6"),
            "timestamp": datetime.now(timezone.utc).isoformat(),
        }
    )