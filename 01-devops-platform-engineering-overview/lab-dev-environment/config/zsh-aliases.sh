# TaskFlow / Platform Engineering bootcamp aliases
# Append to ~/.zshrc:  cat config/zsh-aliases.sh >> ~/.zshrc

# Navigation
alias ..='cd ..'
alias ...='cd ../..'
alias ll='ls -lah'

# Git shortcuts
alias gs='git status -sb'
alias gl='git log --oneline -10'
alias gd='git diff'
alias gco='git checkout'

# Docker shortcuts
alias dps='docker ps --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}"'
alias dlog='docker logs -f'
alias dexec='docker exec -it'

# Terraform shortcuts
alias tf='terraform'
alias tfi='terraform init'
alias tfp='terraform plan'
alias tfa='terraform apply'
alias tfo='terraform output'

# Kubernetes (Week 8+)
alias k='kubectl'
alias kgp='kubectl get pods'
alias kgs='kubectl get svc'

# TaskFlow lab helpers
alias taskflow-health='curl -s http://localhost:8080/health | python3 -m json.tool'