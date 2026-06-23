"""Role-based access control for TaskFlow Platform API."""

from __future__ import annotations

from enum import Enum

from fastapi import HTTPException, status


class Role(str, Enum):
    ADMIN = "admin"
    OPERATOR = "operator"
    VIEWER = "viewer"


class Permission(str, Enum):
    READ = "read"
    WRITE = "write"
    DELETE = "delete"
    ADMIN = "admin"


ROLE_PERMISSIONS: dict[Role, set[Permission]] = {
    Role.ADMIN: {Permission.READ, Permission.WRITE, Permission.DELETE, Permission.ADMIN},
    Role.OPERATOR: {Permission.READ, Permission.WRITE},
    Role.VIEWER: {Permission.READ},
}


def check_permission(role: Role, permission: Permission) -> bool:
    return permission in ROLE_PERMISSIONS.get(role, set())


def require_role(user_role: Role, required: Permission) -> None:
    if not check_permission(user_role, required):
        raise HTTPException(
            status_code=status.HTTP_403_FORBIDDEN,
            detail=f"Role '{user_role.value}' lacks '{required.value}' permission",
        )