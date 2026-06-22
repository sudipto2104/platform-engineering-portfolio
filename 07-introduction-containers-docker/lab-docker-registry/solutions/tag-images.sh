#!/usr/bin/env bash
# Tag TaskFlow images with semantic versioning conventions
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=/dev/null
if [[ -f "${REGISTRY_ENV:-}" ]]; then source "$REGISTRY_ENV"
elif [[ -f "$SCRIPT_DIR/registry.env" ]]; then source "$SCRIPT_DIR/registry.env"
else source "$SCRIPT_DIR/../config/registry.env"; fi

SOURCE_API="${1:-taskflow-api:week7}"
SOURCE_UI="${2:-taskflow-ui:week7}"

docker tag "$SOURCE_API" "${REGISTRY_HOST}/${IMAGE_NAMESPACE}/${API_IMAGE}:latest"
docker tag "$SOURCE_API" "${REGISTRY_HOST}/${IMAGE_NAMESPACE}/${API_IMAGE}:${VERSION}"
docker tag "$SOURCE_UI" "${REGISTRY_HOST}/${IMAGE_NAMESPACE}/${UI_IMAGE}:latest"
docker tag "$SOURCE_UI" "${REGISTRY_HOST}/${IMAGE_NAMESPACE}/${UI_IMAGE}:${VERSION}"

echo "Tagged:"
echo "  ${REGISTRY_HOST}/${IMAGE_NAMESPACE}/${API_IMAGE}:{latest,${VERSION}}"
echo "  ${REGISTRY_HOST}/${IMAGE_NAMESPACE}/${UI_IMAGE}:{latest,${VERSION}}"