variable "domain_name" {
  description = "Nom de domaine pour l'application"
  type        = string
}

variable "subdomain" {
  description = "Sous-domaine pour l'application"
  type        = string
  default     = "www"
}
variable "alb_dns_name" {
  description = "Nom DNS de l'ALB"
  type        = string
}

variable "alb_zone_id" {
  description = "Zone ID de l'ALB"
  type        = string
}

