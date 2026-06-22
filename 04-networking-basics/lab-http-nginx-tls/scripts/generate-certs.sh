#!/usr/bin/env bash
# Generate self-signed TLS cert for TaskFlow lab (development only).
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CERT_DIR="$(cd "$SCRIPT_DIR/../certs" && pwd)"
mkdir -p "$CERT_DIR"

openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
  -keyout "$CERT_DIR/taskflow.key" \
  -out "$CERT_DIR/taskflow.crt" \
  -subj "/CN=api.taskflow.local/O=TaskFlow Bootcamp/C=US" \
  2>/dev/null

echo "Generated $CERT_DIR/taskflow.{crt,key}"