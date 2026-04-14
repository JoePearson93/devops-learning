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

resource "aws_instance" "wordpress" {
  ami                     = "ami-0324bce2436ce02b2"
  instance_type           = "t3.micro"
}
