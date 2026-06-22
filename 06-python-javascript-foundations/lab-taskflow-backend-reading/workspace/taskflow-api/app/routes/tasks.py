from flask import Blueprint, jsonify, request
from pydantic import ValidationError

from app.schemas.task import TaskCreate, TaskListResponse
from app.services.task_service import TaskService

tasks_bp = Blueprint("tasks", __name__)
service = TaskService()


@tasks_bp.get("/tasks")
def list_tasks():
    tasks = service.list_tasks()
    payload = TaskListResponse(tasks=tasks, count=len(tasks))
    return jsonify(payload.model_dump())


@tasks_bp.post("/tasks")
def create_task():
    try:
        data = TaskCreate.model_validate(request.get_json(force=True))
    except ValidationError as exc:
        return jsonify({"errors": exc.errors()}), 422
    task = service.create_task(data)
    return jsonify(task.model_dump()), 201