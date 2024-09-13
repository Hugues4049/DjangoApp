terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  backend "s3" {
    bucket = "projet-tf-backend-state"
    key    = "terraform.tfstate"
    region = "eu-west-3"

  }
}

provider "aws" {
  region = "eu-west-3"
}



module "vpc" {
  source     = "./modules/vpc"
  name       = var.name
  cidr_block = "10.0.0.0/16"
}


module "subnets" {
  source               = "./modules/subnets"
  vpc_id               = module.vpc.vpc_id
  public_subnet_cidrs  = ["10.0.1.0/24", "10.0.2.0/24"]
  private_subnet_cidrs = ["10.0.3.0/24", "10.0.4.0/24"]
  azs                  = ["eu-west-3a", "eu-west-3b"]
  name                 = "main-subnets"
}


module "nat_gateway" {
  source           = "./modules/nat_gateway"
  public_subnet_id = module.subnets.public_subnet_ids[0]
  name             = "main"
}


module "security_groups" {
  source = "./modules/security_groups"
  vpc_id = module.vpc.vpc_id
  name   = "main"
}



module "alb" {
  source     = "./modules/alb"
  name       = "main-alb"
  alb_sg_id  = module.security_groups.alb_sg_id
  subnet_ids = module.subnets.public_subnet_ids
  vpc_id     = module.vpc.vpc_id

}




module "ecs_cluster" {
  source = "./modules/ecs_cluster"

  name                        = var.name
  db_name                     = var.db_name
  db_user                     = var.db_user
  db_password                 = var.db_password
  public_subnet_ids           = module.subnets.public_subnet_ids
  ecs_security_group_id       = module.security_groups.ecs_sg_id
  alb_target_group_arn        = module.alb.target_group_arn
  ecs_task_execution_role_arn = aws_iam_role.ecs_task_execution_role.arn
  rds_endpoint                = module.rds.endpoint

  tags = {
    Name = "${var.name}-ecs-cluster"
  }
}








module "rds" {
  source               = "./modules/rds"
  allocated_storage    = var.allocated_storage
  instance_class       = var.instance_class
  db_name              = var.db_name
  username             = var.username
  password             = var.password
  security_group_id    = module.security_groups.rds_sg_id
  db_subnet_group_name = "main-subnet-group"
  subnet_ids           = module.subnets.private_subnet_ids
  private_subnet_ids   = module.subnets.private_subnet_ids
  name                 = "postgres-instance"
}





module "route53" {
  source      = "./modules/route53"
  domain_name = "roland_ebe.net" # Remplacez par votre nom de domaine
  subdomain   = "www"

  alb_dns_name = module.alb.dns_name
  alb_zone_id  = module.alb.zone_id
}




resource "aws_iam_role" "ecs_task_execution_role" {
  name = "ecsTaskExecutionRole"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "ecs_task_execution_policy" {
  role       = aws_iam_role.ecs_task_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}
