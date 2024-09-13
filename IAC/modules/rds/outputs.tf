output "rds_endpoint" {
  value = aws_db_instance.postgres.endpoint
}


output "endpoint" {
  description = "Endpoint de la base de données RDS"
  value       = aws_db_instance.postgres.endpoint
}



