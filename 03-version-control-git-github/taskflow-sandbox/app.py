"""TaskFlow sandbox — Week 3 Git & CI/CD practice repo."""

from __future__ import annotations

import os
from datetime import datetime, timezone

from flask import Flask, jsonify

app = Flask(__name__)

TASKS = [
    {"id": 1, "title": "Initialize Git repo", "status": "done", "owner": "platform-team"},
    {"id": 2, "title": "Add CI quality gates", "status": "in_progress", "owner": "platform-team"},
    {"id": 3, "title": "Ship PR workflow", "status": "todo", "owner": "platform-team"},
]


@app.get("/health")
def health():
    return jsonify(
        {
            "status": "healthy",
            "service": "taskflow",
"week3-resolved"
            "timestamp": datetime.now(timezone.utc).isoformat(),
        }
    )


@app.get("/api/tasks")
def list_tasks():
    return jsonify({"tasks": TASKS, "count": len(TASKS)})


if __name__ == "__main__":
    app.run(host="0.0.0.0", port=int(os.getenv("PORT", "8080")))