terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.40.0"
    }
  }
  required_version = ">= 1.5.0"
}

provider "aws" {
  region = "eu-west-1"
}

module "iam" {
  source = "./modules/iam"
}

module "security_groups" {
  source       = "./modules/security_groups"
  project_name = var.project_name
  my_ip        = var.my_ip
  open_cidr    = var.open_cidr
}

module "ec2" {
  source               = "./modules/ec2"
  ami_id               = var.ami_id
  instance_type        = var.instance_type
  security_group_id    = module.security_groups.wordpress_sg_id
  public_key_path      = var.public_key_path
  iam_instance_profile = module.iam.wordpress_profile_name
  database_password    = var.database_password
  associate_public_ip  = var.associate_public_ip
}