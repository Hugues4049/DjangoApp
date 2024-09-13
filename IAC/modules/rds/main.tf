resource "aws_db_instance" "postgres" {
  allocated_storage = var.allocated_storage
  engine            = "postgres"
  engine_version    = "13.16"
  instance_class    = var.instance_class
  #name                   = var.db_name
  username               = var.username
  password               = var.password
  parameter_group_name   = "default.postgres13"
  publicly_accessible    = false
  vpc_security_group_ids = [var.security_group_id]
  db_subnet_group_name   = aws_db_subnet_group.main.name

  # Garder le snapshot final activé et fournir un identifiant
  skip_final_snapshot       = false
  final_snapshot_identifier = "final-snapshot-postgres"

  tags = {
    Name = var.name
  }
}




resource "aws_db_subnet_group" "main" {
  name        = "main-subnet-group"
  description = "Subnet group for RDS"
  subnet_ids  = var.private_subnet_ids

  tags = {
    Name = "main-subnet-group"
  }
}




