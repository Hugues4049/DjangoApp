variable "public_subnet_id" {
  description = "ID of the public subnet where NAT Gateway is deployed"
  type        = string
}

variable "name" {
  description = "Name tag for the NAT Gateway"
  type        = string
}
