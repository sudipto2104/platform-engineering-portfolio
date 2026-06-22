#!/usr/bin/env bash
# Apply dev environment configuration (non-interactive defaults where possible).
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LAB_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"

echo "=== Dev Environment Lab — Solve ==="
echo

# Git identity (use env vars or sensible defaults)
GIT_NAME="${GIT_AUTHOR_NAME:-TaskFlow Student}"
GIT_EMAIL="${GIT_AUTHOR_EMAIL:-student@taskflow.local}"

echo "→ Configuring Git ($GIT_NAME <$GIT_EMAIL>)"
git config --global user.name "$GIT_NAME"
git config --global user.email "$GIT_EMAIL"
git config --global init.defaultBranch main
git config --global pull.rebase false
git config --global color.ui auto

# SSH key
SSH_KEY="${HOME}/.ssh/id_ed25519"
if [[ ! -f "$SSH_KEY" ]]; then
  echo "→ Generating SSH key"
  mkdir -p "${HOME}/.ssh"
  chmod 700 "${HOME}/.ssh"
  ssh-keygen -t ed25519 -C "$GIT_EMAIL" -f "$SSH_KEY" -N "" -q
  echo "  created $SSH_KEY"
else
  echo "→ SSH key already exists: $SSH_KEY"
fi

# Aliases
MARKER="Platform Engineering bootcamp aliases"
if [[ -f "${HOME}/.zshrc" ]] && grep -q "$MARKER" "${HOME}/.zshrc" 2>/dev/null; then
  echo "→ Aliases already in ~/.zshrc"
else
  echo "→ Appending aliases to ~/.zshrc"
  {
    echo ""
    echo "# $MARKER"
    cat "$LAB_DIR/config/zsh-aliases.sh"
  } >> "${HOME}/.zshrc"
fi

# oh-my-zsh (optional, skip if present)
if [[ ! -d "${HOME}/.oh-my-zsh" ]]; then
  echo "→ Installing oh-my-zsh (unattended)"
  if command -v curl &>/dev/null; then
    RUNZSH=no CHSH=no sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended 2>/dev/null \
      && echo "  oh-my-zsh installed" \
      || echo "  oh-my-zsh install skipped (network or permissions)"
  fi
else
  echo "→ oh-my-zsh already installed"
fi

# VS Code extensions
if command -v code &>/dev/null; then
  echo "→ Installing VS Code extensions"
  while IFS= read -r ext; do
    [[ -z "$ext" || "$ext" =~ ^# ]] && continue
    code --install-extension "$ext" --force 2>/dev/null || true
  done < "$LAB_DIR/vscode-extensions.txt"
else
  echo "→ VS Code CLI not found — skip extension install"
  echo "  Install VS Code and run: cat vscode-extensions.txt | grep -v '^#' | xargs -L1 code --install-extension"
fi

echo
if [[ -f "${SSH_KEY}.pub" ]]; then
  echo "Add your SSH public key to GitHub:"
  cat "${SSH_KEY}.pub"
  echo
fi

echo "Run ./scripts/check.sh to verify."