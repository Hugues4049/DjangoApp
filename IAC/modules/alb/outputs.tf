output "dns_name" {
  description = "Le nom DNS de l'ALB"
  value       = aws_lb.main.dns_name
}

output "zone_id" {
  description = "L'ID de la zone de l'ALB"
  value       = aws_lb.main.zone_id
}
