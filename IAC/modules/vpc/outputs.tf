output "vpc_id" {
  description = "ID du VPC"
  value       = aws_vpc.main.id
}

output "igw_id" {
  value = aws_internet_gateway.igw.id
}
