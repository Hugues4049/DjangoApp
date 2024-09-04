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
  cidr_block = "10.0.0.0/16"
  name       = "main-vpc"
}

module "subnets" {
  source               = "./modules/subnets"
  vpc_id               = module.vpc.vpc_id
  public_subnet_cidrs  = ["10.0.1.0/24", "10.0.2.0/24"]
  private_subnet_cidrs = ["10.0.3.0/24", "10.0.4.0/24"]
  azs                  = ["us-west-1a", "us-west-1b"]
  name                 = "main-subnets"
}

module "nat_gateway" {
  source           = "./modules/nat_gateway"
  public_subnet_id = element(module.subnets.public_subnet_ids, 0)
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
  name   = "main-cluster"
}

module "rds" {
  source               = "./modules/rds"
  allocated_storage    = 20
  instance_class       = "db.t2.micro"
  db_name              = "mydatabase"
  username             = "admin"
  password             = "yourpassword"
  security_group_id    = module.security_groups.rds_sg_id
  db_subnet_group_name = "main-subnet-group"
  subnet_ids           = module.subnets.private_subnet_ids
  name                 = "postgres-instance"
}

