"""TaskFlow — bootcamp task management platform (Week 1 stub)."""

from __future__ import annotations

import os
from datetime import datetime, timezone

from flask import Flask, jsonify

app = Flask(__name__)

TASKS = [
    {"id": 1, "title": "Set up dev environment", "status": "done", "owner": "platform-team"},
    {"id": 2, "title": "Containerize TaskFlow", "status": "in_progress", "owner": "platform-team"},
    {"id": 3, "title": "Deploy with Terraform", "status": "todo", "owner": "platform-team"},
]


@app.get("/health")
def health():
    return jsonify(
        {
            "status": "healthy",
            "service": "taskflow",
            "version": os.getenv("TASKFLOW_VERSION", "week1"),
            "timestamp": datetime.now(timezone.utc).isoformat(),
        }
    )


@app.get("/")
def index():
    return jsonify(
        {
            "message": "Welcome to TaskFlow",
            "description": "Task management platform for the Platform Engineering bootcamp",
            "endpoints": ["/health", "/api/tasks"],
        }
    )


@app.get("/api/tasks")
def list_tasks():
    return jsonify({"tasks": TASKS, "count": len(TASKS)})


if __name__ == "__main__":
    app.run(host="0.0.0.0", port=int(os.getenv("PORT", "8080")))