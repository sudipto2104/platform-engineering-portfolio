# TaskFlow on AWS (Week 10)

| Service | TaskFlow use |
|---------|--------------|
| EC2 | Host Docker Compose stack (web tier) |
| S3 | Task file attachments via boto3 |
| ECR | Private container registry (migrate from Docker Hub) |
| VPC | 3-tier network (public web, private app, private data) |
| IAM | Instance profiles, least-privilege policies |

Network CIDR aligns with Week 4 plan: `10.30.0.0/16` production VPC.