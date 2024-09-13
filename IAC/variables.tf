variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "eu-west-3"
}

# variables.tf à la racine du projet ou dans les modules concernés

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

variable "username" {
  description = "Nom d'utilisateur de la base de données RDS"
  type        = string
}

variable "password" {
  description = "Mot de passe de la base de données RDS"
  type        = string
  sensitive   = true
}

variable "allocated_storage" {
  description = "Capacité de stockage de la base de données RDS"
  type        = number
  default     = 20
}

variable "instance_class" {
  description = "Classe d'instance pour RDS"
  type        = string
  default     = "db.t3.micro"
}


variable "domain_name" {
  description = "Nom de domaine pour l'application"
  type        = string
  default     = "my4049.com"
}
