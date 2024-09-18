variable "name" {
  description = "The name of the ALB"
  type        = string
}

variable "alb_sg_id" {
  description = "The security group ID associated with the ALB"
  type        = string
}

variable "subnet_ids" {
  description = "List of subnet IDs where the ALB should be deployed"
  type        = list(string)
}

variable "vpc_id" {
  description = "The VPC ID for the ALB"
  type        = string
}
