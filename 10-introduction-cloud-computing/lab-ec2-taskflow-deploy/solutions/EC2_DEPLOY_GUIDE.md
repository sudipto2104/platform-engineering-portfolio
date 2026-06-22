# EC2 TaskFlow Deployment Guide

## Architecture

```
Internet → EC2 (public subnet) → Nginx :80 → Docker Compose (api, ui, postgres, redis)
```

## Steps

1. Create security groups from `security-groups.json`
2. Launch Amazon Linux 2023 EC2 (t3.medium) in public subnet
3. Attach `taskflow-web-sg`, assign Elastic IP optional
4. User-data runs `user-data.sh` — installs Docker + Compose
5. Copy `docker-compose.ec2.yml` and `nginx-ec2.conf` to instance
6. Verify: `curl http://<public-ip>/health`

## Instance profile

Attach IAM role with SSM + ECR read (Week 10 Lab 2) for hardened access without long-lived keys.