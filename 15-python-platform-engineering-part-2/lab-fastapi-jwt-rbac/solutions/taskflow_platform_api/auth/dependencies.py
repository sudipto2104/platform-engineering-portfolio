"""FastAPI dependencies for authentication."""

from __future__ import annotations

from typing import Annotated

from fastapi import Depends, HTTPException, status
from fastapi.security import OAuth2PasswordBearer
from pydantic import BaseModel

from .jwt_handler import decode_access_token
from .rbac import Permission, Role, require_role

oauth2_scheme = OAuth2PasswordBearer(tokenUrl="/api/v1/auth/login")


class TokenUser(BaseModel):
    email: str
    role: Role


def get_current_user(token: Annotated[str, Depends(oauth2_scheme)]) -> TokenUser:
    payload = decode_access_token(token)
    if not payload:
        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED,
            detail="Invalid or expired token",
            headers={"WWW-Authenticate": "Bearer"},
        )
    return TokenUser(email=payload["sub"], role=Role(payload["role"]))


def require_permission(permission: Permission):
    def _checker(user: Annotated[TokenUser, Depends(get_current_user)]) -> TokenUser:
        require_role(user.role, permission)
        return user

    return _checker