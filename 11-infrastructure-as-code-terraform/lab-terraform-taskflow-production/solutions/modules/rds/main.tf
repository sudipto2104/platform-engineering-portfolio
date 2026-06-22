resource "aws_db_subnet_group" "this" {
  name       = "${var.project}-${var.environment}-db"
  subnet_ids = var.subnet_ids
}

resource "aws_db_instance" "postgres" {
  identifier             = "${var.project}-${var.environment}-postgres"
  engine                 = "postgres"
  engine_version         = "16"
  instance_class         = "db.t3.medium"
  allocated_storage      = 20
  db_name                = "taskflow"
  username               = "taskflow"
  password               = var.db_password
  db_subnet_group_name   = aws_db_subnet_group.this.name
  vpc_security_group_ids = var.security_group_ids
  multi_az               = true
  skip_final_snapshot    = true
  tags = { Name = "${var.project}-postgres", Tier = "database" }
}