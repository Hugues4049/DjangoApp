resource "aws_db_instance" "postgres" {
  allocated_storage = var.allocated_storage
  engine            = "postgres"
  engine_version    = "13.4"
  instance_class    = var.instance_class
  #name                   = var.db_name
  username               = var.username
  password               = var.password
  parameter_group_name   = "default.postgres13"
  publicly_accessible    = false
  vpc_security_group_ids = [var.security_group_id]
  db_subnet_group_name   = var.db_subnet_group_name

  tags = {
    Name = var.name
  }
}

resource "aws_db_subnet_group" "main" {
  name       = var.db_subnet_group_name
  subnet_ids = var.subnet_ids

  tags = {
    Name = var.db_subnet_group_name
  }
}

output "rds_endpoint" {
  value = aws_db_instance.postgres.endpoint
}
