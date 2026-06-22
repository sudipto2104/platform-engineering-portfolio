#!/bin/bash
# EC2 cloud-init — install Docker and deploy TaskFlow
set -euo pipefail

yum update -y
yum install -y docker nginx git
systemctl enable docker nginx
systemctl start docker

curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" \
  -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose

mkdir -p /opt/taskflow
cp /tmp/taskflow/docker-compose.yml /opt/taskflow/
cp /tmp/taskflow/nginx.conf /etc/nginx/conf.d/taskflow.conf
systemctl reload nginx

cd /opt/taskflow
docker-compose pull || true
docker-compose up -d
echo "TaskFlow EC2 bootstrap complete"