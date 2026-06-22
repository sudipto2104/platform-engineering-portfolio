#!/usr/bin/env bash
# Migrate TaskFlow images from local/Docker Hub to AWS ECR
set -euo pipefail

AWS_REGION="${AWS_REGION:-us-east-1}"
AWS_ACCOUNT_ID="${AWS_ACCOUNT_ID:?Set AWS_ACCOUNT_ID}"
ECR_REGISTRY="${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com"

login_ecr() {
  aws ecr get-login-password --region "$AWS_REGION" \
    | docker login --username AWS --password-stdin "$ECR_REGISTRY"
}

ensure_repo() {
  local name="$1"
  aws ecr describe-repositories --repository-names "$name" --region "$AWS_REGION" 2>/dev/null \
    || aws ecr create-repository --repository-name "$name" --region "$AWS_REGION"
}

tag_and_push() {
  local local_image="$1" repo="$2" tag="${3:-latest}"
  local target="${ECR_REGISTRY}/taskflow/${repo}:${tag}"
  docker tag "$local_image" "$target"
  docker push "$target"
  echo "Pushed $target"
}

login_ecr
ensure_repo taskflow-api
ensure_repo taskflow-ui
tag_and_push taskflow-api:week7 taskflow-api v1.0.0
tag_and_push taskflow-ui:week7 taskflow-ui v1.0.0
echo "ECR migration complete"