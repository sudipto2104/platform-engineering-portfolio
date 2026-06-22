#!/usr/bin/env bash
# Reference UFW rules for TaskFlow staging — run on Ubuntu with sudo.
set -euo pipefail

sudo ufw default deny incoming
sudo ufw default allow outgoing
sudo ufw allow OpenSSH
sudo ufw allow 80/tcp comment 'TaskFlow nginx HTTP'
sudo ufw allow 443/tcp comment 'TaskFlow nginx HTTPS'
sudo ufw --force enable
sudo ufw status verbose