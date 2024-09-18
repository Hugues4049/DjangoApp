variable "name" {
  description = "Nom du projet ou de l'application"
  type        = string
}

variable "db_name" {
  description = "Nom de la base de données"
  type        = string
}

variable "db_user" {
  description = "Nom d'utilisateur de la base de données"
  type        = string
}

variable "db_password" {
  description = "Mot de passe de la base de données"
  type        = string
  sensitive   = true
}

variable "public_subnet_ids" {
  description = "Sous-réseaux publics pour ECS"
  type        = list(string)
}

variable "ecs_security_group_id" {
  description = "ID du groupe de sécurité pour ECS"
  type        = string
}



variable "ecs_task_execution_role_arn" {
  description = "ARN du rôle d'exécution ECS"
  type        = string
}

variable "rds_endpoint" {
  description = "Endpoint de la base de données RDS"
  type        = string
}

variable "security_group_id" {
  description = "ID du groupe de sécurité utilisé pour ECS"
  type        = string
}
variable "tags" {
  description = "Les tags à appliquer à toutes les ressources"
  type        = map(string)
  default     = {} # Vous pouvez mettre des valeurs par défaut si nécessaire
}



variable "alb_dns_name" {
  description = "DNS name of the ALB"
  type        = string
}

variable "alb_zone_id" {
  description = "The zone ID of the ALB"
  type        = string
}



variable "alb_listener" {
  description = "The ARN of the ALB Listener"
  type        = string
}



variable "alb_listener_arn" {
  description = "The ARN of the ALB Listener"
  type        = string
}
variable "alb_target_group_arn" {
  description = "The ARN of the ALB Target Group"
  type        = string
}
