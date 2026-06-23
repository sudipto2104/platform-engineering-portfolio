"""Authentication endpoints."""

from __future__ import annotations

from typing import Annotated

from fastapi import APIRouter, Depends, HTTPException, status
from fastapi.security import OAuth2PasswordRequestForm
from pydantic import BaseModel

from ..auth.dependencies import TokenUser, get_current_user
from ..auth.jwt_handler import create_access_token
from ..users import authenticate_user

router = APIRouter(prefix="/api/v1/auth", tags=["authentication"])


class TokenResponse(BaseModel):
    access_token: str
    token_type: str = "bearer"


@router.post("/login", response_model=TokenResponse)
def login(form: Annotated[OAuth2PasswordRequestForm, Depends()]):
    user = authenticate_user(form.username, form.password)
    if not user:
        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED,
            detail="Invalid credentials",
            headers={"WWW-Authenticate": "Bearer"},
        )
    token = create_access_token({"sub": user["email"], "role": user["role"].value})
    return TokenResponse(access_token=token)


@router.get("/me")
def me(current_user: Annotated[TokenUser, Depends(get_current_user)]):
    return {"email": current_user.email, "role": current_user.role.value}