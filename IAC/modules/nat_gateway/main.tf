resource "aws_eip" "nat_eip" {
  domain = "vpc"
}

resource "aws_nat_gateway" "nat_gw" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = var.public_subnet_id

  tags = {
    Name = "${var.name}-nat-gw"
  }
}

output "nat_gateway_id" {
  value = aws_nat_gateway.nat_gw.id
}
