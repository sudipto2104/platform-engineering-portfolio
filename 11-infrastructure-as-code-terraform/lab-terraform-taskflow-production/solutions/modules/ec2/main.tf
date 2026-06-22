data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "name"
    values = ["al2023-ami-*-x86_64"]
  }
}

resource "aws_instance" "app" {
  count                       = var.app_count
  ami                         = data.aws_ami.amazon_linux.id
  instance_type               = var.instance_type
  subnet_id                   = var.subnet_ids[count.index % length(var.subnet_ids)]
  vpc_security_group_ids      = var.security_group_ids
  iam_instance_profile        = var.instance_profile_name
  associate_public_ip_address = false
  user_data = base64encode(<<-EOF
    #!/bin/bash
    yum install -y docker
    systemctl enable docker && systemctl start docker
    echo "TaskFlow app node ${count.index + 1} ready"
  EOF
  )
  tags = {
    Name = "${var.project}-${var.environment}-app-${count.index + 1}"
    Tier = "application"
  }
}