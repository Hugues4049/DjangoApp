variable "name" {
  description = "Le nom de l'ALB"
  type        = string
}

variable "alb_sg_id" {
  description = "L'ID du groupe de sécurité associé à l'ALB"
  type        = string
}

variable "subnet_ids" {
  description = "Liste des sous-réseaux où déployer l'ALB"
  type        = list(string)
}

variable "vpc_id" {
  description = "L'ID du VPC pour l'ALB"
  type        = string
}
