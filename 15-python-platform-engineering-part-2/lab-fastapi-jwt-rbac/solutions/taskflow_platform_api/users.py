"""In-memory user store for JWT authentication demo."""

from __future__ import annotations

from passlib.context import CryptContext

from .auth.rbac import Role

pwd_context = CryptContext(schemes=["bcrypt"], deprecated="auto")

USERS_DB: dict[str, dict] = {
    "admin@taskflow.io": {
        "email": "admin@taskflow.io",
        "hashed_password": pwd_context.hash("admin123"),
        "role": Role.ADMIN,
    },
    "operator@taskflow.io": {
        "email": "operator@taskflow.io",
        "hashed_password": pwd_context.hash("operator123"),
        "role": Role.OPERATOR,
    },
    "viewer@taskflow.io": {
        "email": "viewer@taskflow.io",
        "hashed_password": pwd_context.hash("viewer123"),
        "role": Role.VIEWER,
    },
}


def verify_password(plain: str, hashed: str) -> bool:
    return pwd_context.verify(plain, hashed)


def authenticate_user(email: str, password: str) -> dict | None:
    user = USERS_DB.get(email)
    if not user or not verify_password(password, user["hashed_password"]):
        return None
    return user