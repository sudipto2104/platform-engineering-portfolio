#!/usr/bin/env bash
# Interactive Git + SSH setup for the Platform Engineering bootcamp.
set -euo pipefail

echo "=== Git & SSH Setup ==="
echo

if ! command -v git &>/dev/null; then
  echo "ERROR: git is not installed. Install Xcode CLI tools or git before continuing."
  exit 1
fi

# Git identity
CURRENT_NAME=$(git config --global user.name 2>/dev/null || true)
CURRENT_EMAIL=$(git config --global user.email 2>/dev/null || true)

read -rp "Git user.name [${CURRENT_NAME:-Your Name}]: " NAME
NAME="${NAME:-${CURRENT_NAME:-Your Name}}"
read -rp "Git user.email [${CURRENT_EMAIL:-you@example.com}]: " EMAIL
EMAIL="${EMAIL:-${CURRENT_EMAIL:-you@example.com}}"

git config --global user.name "$NAME"
git config --global user.email "$EMAIL"
git config --global init.defaultBranch main
git config --global pull.rebase false
git config --global color.ui auto

echo
echo "Git configured:"
git config --global --list | grep -E 'user\.|init\.|pull\.|color\.'

# SSH key
SSH_KEY="${HOME}/.ssh/id_ed25519"
if [[ -f "$SSH_KEY" ]]; then
  echo
  echo "SSH key already exists: $SSH_KEY"
else
  echo
  read -rp "Generate SSH key for GitHub? [Y/n]: " GEN
  GEN="${GEN:-Y}"
  if [[ "$GEN" =~ ^[Yy] ]]; then
    mkdir -p "${HOME}/.ssh"
    chmod 700 "${HOME}/.ssh"
    ssh-keygen -t ed25519 -C "$EMAIL" -f "$SSH_KEY" -N ""
    echo "SSH key created."
  fi
fi

if [[ -f "$SSH_KEY.pub" ]]; then
  echo
  echo "Add this public key to GitHub → Settings → SSH and GPG keys:"
  echo "─────────────────────────────────────────────────────────────"
  cat "$SSH_KEY.pub"
  echo "─────────────────────────────────────────────────────────────"
  echo
  echo "Test with: ssh -T git@github.com"
fi