#!/usr/bin/env bash
# Pull images from simulated registry (or mock tar store)
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=/dev/null
if [[ -f "${REGISTRY_ENV:-}" ]]; then source "$REGISTRY_ENV"
elif [[ -f "$SCRIPT_DIR/registry.env" ]]; then source "$SCRIPT_DIR/registry.env"
else source "$SCRIPT_DIR/../config/registry.env"; fi

MOCK_MODE="${MOCK_MODE:-0}"

if [[ "$MOCK_MODE" == "1" ]]; then
  STORE="${SCRIPT_DIR}/mock-registry"
  docker load -i "$STORE/${API_IMAGE}-${VERSION}.tar"
  docker load -i "$STORE/${UI_IMAGE}-${VERSION}.tar"
  echo "Mock pull from $STORE"
  exit 0
fi

docker pull "${REGISTRY_HOST}/${IMAGE_NAMESPACE}/${API_IMAGE}:${VERSION}"
docker pull "${REGISTRY_HOST}/${IMAGE_NAMESPACE}/${UI_IMAGE}:${VERSION}"
echo "Pulled ${VERSION} from ${REGISTRY_HOST}"