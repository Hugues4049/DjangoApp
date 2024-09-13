

output "public_subnet_ids" {
  description = "Liste des IDs des sous-réseaux publics"
  value       = aws_subnet.public_subnet[*].id
}

output "private_subnet_ids" {
  description = "Liste des IDs des sous-réseaux privés"
  value       = aws_subnet.private_subnet[*].id
}
