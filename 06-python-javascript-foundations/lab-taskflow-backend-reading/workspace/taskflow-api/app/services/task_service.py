"""Business logic — decouples routes from persistence."""

from app.schemas.task import TaskCreate, TaskRead

# Week 6 in-memory seed data (replaced by DB session in later weeks)
_SEED = [
    TaskRead(id=1, title="Read backend startup code", status="in_progress", owner="platform-team"),
    TaskRead(id=2, title="Map API routes", status="todo", owner="platform-team"),
    TaskRead(id=3, title="Review validation schemas", status="todo", owner="platform-team"),
]


class TaskService:
    def __init__(self) -> None:
        self._tasks: list[TaskRead] = list(_SEED)
        self._next_id = 4

    def list_tasks(self) -> list[TaskRead]:
        return list(self._tasks)

    def create_task(self, data: TaskCreate) -> TaskRead:
        task = TaskRead(id=self._next_id, **data.model_dump())
        self._next_id += 1
        self._tasks.append(task)
        return task