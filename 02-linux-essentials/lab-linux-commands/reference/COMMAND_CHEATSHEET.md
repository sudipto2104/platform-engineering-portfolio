# Linux Command Cheatsheet — 50+ Essentials (TaskFlow / Platform Engineering)

## Navigation (8)

| Command | Purpose |
|---------|---------|
| `pwd` | Print working directory |
| `cd` | Change directory |
| `cd ~` | Home directory |
| `cd -` | Previous directory |
| `ls` | List files |
| `ls -la` | Long listing incl. hidden |
| `tree` | Directory tree (install if needed) |
| `pushd` / `popd` | Directory stack |

## File operations (12)

| Command | Purpose |
|---------|---------|
| `touch` | Create empty file / update timestamp |
| `mkdir -p` | Create directory path |
| `cp -r` | Copy recursively |
| `mv` | Move or rename |
| `rm` | Remove file |
| `rm -rf` | Remove directory tree (careful!) |
| `ln -s` | Symbolic link |
| `find` | Search files by name/type/time |
| `locate` | Fast filename search (updatedb) |
| `chmod` | Change permissions |
| `chown` | Change owner |
| `umask` | Default permission mask |

## Viewing files (10)

| Command | Purpose |
|---------|---------|
| `cat` | Concatenate / view file |
| `less` | Paginated viewer |
| `head` | First lines |
| `tail` | Last lines |
| `tail -f` | Follow log file |
| `wc -l` | Line count |
| `file` | File type detection |
| `stat` | File metadata |
| `diff` | Compare files |
| `md5sum` | Checksum |

## Searching (8)

| Command | Purpose |
|---------|---------|
| `grep` | Pattern search |
| `grep -r` | Recursive search |
| `grep -i` | Case insensitive |
| `which` | Locate executable |
| `whereis` | Binary, source, man paths |
| `type` | Command type (alias/builtin) |
| `history` | Command history |
| `alias` | Command shortcuts |

## Processes & system (10)

| Command | Purpose |
|---------|---------|
| `ps aux` | Process list |
| `top` | Live process view |
| `htop` | Interactive top |
| `kill` | Send signal to PID |
| `killall` | Kill by name |
| `nohup` | Immune to hangups |
| `df -h` | Disk free human-readable |
| `du -sh` | Directory size |
| `free -h` | Memory usage |
| `uname -a` | Kernel / system info |

## Networking (6)

| Command | Purpose |
|---------|---------|
| `ip addr` | Interface addresses |
| `ss -tuln` | Listening sockets |
| `ping` | ICMP reachability |
| `curl` | HTTP client (TaskFlow `/health`) |
| `scp` | Secure copy |
| `ssh` | Remote shell |

## Archives & pipes (6)

| Command | Purpose |
|---------|---------|
| `tar -czvf` | Create gzip archive |
| `tar -xzvf` | Extract archive |
| `gzip` / `gunzip` | Compress / decompress |
| `|` | Pipe stdout → stdin |
| `>` / `>>` | Redirect stdout |
| `2>&1` | Redirect stderr to stdout |

## TaskFlow examples

```bash
# Find all Python files in TaskFlow
find ../01-devops-platform-engineering-overview/taskflow -name '*.py'

# Watch TaskFlow logs
tail -f ../../taskflow-workspace/logs/taskflow.log

# Disk usage of bootcamp repos
du -sh ~/platform-engineering-portfolio

# Health check
curl -s http://localhost:8080/health | head
```