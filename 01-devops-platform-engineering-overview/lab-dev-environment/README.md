# Lab: Development Environment Setup

Set up a consistent, production-ready development environment before Week 2 platform engineering work.

## Goals

By the end of this lab you will have:

- VS Code with platform engineering extensions
- Terminal configured with productivity enhancements
- Git installed and configured with SSH authentication
- A verified environment ready for hands-on labs

## Steps

### 1. Install VS Code extensions

```bash
code --install-extension ms-vscode-remote.remote-ssh
code --install-extension ms-azuretools.vscode-docker
code --install-extension hashicorp.terraform
code --install-extension redhat.vscode-yaml
code --install-extension ms-python.python
code --install-extension eamodio.gitlens
code --install-extension github.vscode-github-actions
```

Or install all at once:

```bash
cat vscode-extensions.txt | grep -v '^#' | xargs -L1 code --install-extension
```

### 2. Configure terminal

```bash
# Install oh-my-zsh (if not present)
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

# Add platform engineering aliases
cat config/zsh-aliases.sh >> ~/.zshrc
source ~/.zshrc
```

### 3. Configure Git and SSH

```bash
./config/git-setup.sh
```

Follow the prompts to set `user.name`, `user.email`, and generate an SSH key for GitHub.

### 4. Verify

```bash
./scripts/check.sh
```

## Solution

```bash
./scripts/solve.sh
```

This applies local configuration (Git identity, aliases, SSH key generation) and prints a verification report. VS Code extensions require the `code` CLI — install VS Code first if checks fail.