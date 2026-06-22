# Git Basics — TaskFlow Sandbox

```bash
export SANDBOX=../taskflow-sandbox
cd "$SANDBOX"
```

## Configure Git

```bash
git config user.name "Your Name"
git config user.email "you@example.com"
git config init.defaultBranch main
git config pull.rebase false
```

## Initialize & commit

```bash
git init
git status
git add README.md app.py requirements.txt .gitignore
git commit -m "feat: initial TaskFlow week3 sandbox"
echo "# Week 3" >> README.md
git add README.md
git commit -m "docs: note week3 git practice"
git log --oneline
```

## Portfolio structure

```
taskflow-sandbox/
├── README.md
├── app.py
├── requirements.txt
└── .gitignore
```

Record outputs in `deliverables/GIT_SETUP_LOG.md`.