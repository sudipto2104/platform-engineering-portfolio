#!/usr/bin/env bash
# Automated ArgoCD rollback for TaskFlow applications
set -euo pipefail

APP_NAME="${1:-taskflow-production}"
HISTORY_ID="${2:-}"

echo "=== TaskFlow GitOps Rollback ==="

if [[ -z "$HISTORY_ID" ]]; then
  echo "Available deployment history for $APP_NAME:"
  argocd app history "$APP_NAME" 2>/dev/null || kubectl get application "$APP_NAME" -n argocd -o jsonpath='{.status.history}' | jq .
  echo "Usage: $0 <app-name> <history-id>"
  exit 1
fi

echo "Rolling back $APP_NAME to history id $HISTORY_ID..."
argocd app rollback "$APP_NAME" "$HISTORY_ID"

echo "Verifying sync status..."
argocd app wait "$APP_NAME" --health --timeout 300

echo "Rollback complete. Audit entry logged in ArgoCD UI → History."