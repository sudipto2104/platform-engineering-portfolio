#!/usr/bin/env bash
# Verify development environment prerequisites for the bootcamp.
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LAB_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"

PASS=0
FAIL=0
WARN=0

pass() { echo "✓ $1"; PASS=$((PASS + 1)); }
fail() { echo "✗ $1"; FAIL=$((FAIL + 1)); }
warn() { echo "⚠ $1"; WARN=$((WARN + 1)); }

echo "=== Dev Environment Lab — Check ==="
echo

# Core tools
command -v git &>/dev/null && pass "Git installed ($(git --version | head -1))" || fail "Git installed"
command -v docker &>/dev/null && pass "Docker installed" || warn "Docker installed (required from Week 7; OK to install later)"
command -v terraform &>/dev/null && pass "Terraform installed" || warn "Terraform installed (required for platform-path lab)"
command -v python3 &>/dev/null && pass "Python 3 installed" || fail "Python 3 installed"
command -v curl &>/dev/null && pass "curl installed" || fail "curl installed"

# Git configuration
if git config --global user.name &>/dev/null && [[ -n "$(git config --global user.name)" ]]; then
  pass "Git user.name configured ($(git config --global user.name))"
else
  fail "Git user.name configured"
fi

if git config --global user.email &>/dev/null && [[ -n "$(git config --global user.email)" ]]; then
  pass "Git user.email configured ($(git config --global user.email))"
else
  fail "Git user.email configured"
fi

# SSH
if [[ -f "${HOME}/.ssh/id_ed25519" || -f "${HOME}/.ssh/id_rsa" ]]; then
  pass "SSH key pair exists"
else
  fail "SSH key pair exists (~/.ssh/id_ed25519 or id_rsa)"
fi

# Terminal enhancements
if [[ -d "${HOME}/.oh-my-zsh" ]]; then
  pass "oh-my-zsh installed"
else
  warn "oh-my-zsh installed (recommended — run solve.sh)"
fi

if [[ -f "${HOME}/.zshrc" ]] && grep -q "Platform Engineering bootcamp aliases" "${HOME}/.zshrc" 2>/dev/null; then
  pass "Platform engineering aliases in ~/.zshrc"
else
  warn "Platform engineering aliases in ~/.zshrc (run solve.sh)"
fi

# VS Code
if command -v code &>/dev/null; then
  pass "VS Code CLI (code) available"
  EXT_FILE="$LAB_DIR/vscode-extensions.txt"
  MISSING=0
  while IFS= read -r ext; do
    [[ -z "$ext" || "$ext" =~ ^# ]] && continue
    if ! code --list-extensions 2>/dev/null | grep -qi "^${ext}$"; then
      MISSING=$((MISSING + 1))
    fi
  done < "$EXT_FILE"
  if [[ "$MISSING" -eq 0 ]]; then
    pass "All recommended VS Code extensions installed"
  else
    warn "$MISSING VS Code extension(s) missing — run: cat vscode-extensions.txt | grep -v '^#' | xargs -L1 code --install-extension"
  fi
else
  warn "VS Code CLI (code) available — install VS Code and enable 'code' in PATH"
fi

# Lab artifacts
[[ -f "$LAB_DIR/vscode-extensions.txt" ]] && pass "vscode-extensions.txt present" || fail "vscode-extensions.txt present"
[[ -f "$LAB_DIR/config/zsh-aliases.sh" ]] && pass "zsh-aliases.sh present" || fail "zsh-aliases.sh present"
[[ -f "$LAB_DIR/config/git-setup.sh" ]] && pass "git-setup.sh present" || fail "git-setup.sh present"

echo
echo "Results: $PASS passed, $FAIL failed, $WARN warnings"
if [[ "$FAIL" -gt 0 ]]; then
  echo "Run ./scripts/solve.sh to fix Git/SSH/alias setup, then address remaining items."
  exit 1
fi
echo "Dev environment ready (warnings are optional enhancements)."