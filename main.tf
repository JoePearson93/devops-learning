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

resource "aws_instance" "wordpress"{
  ami                     = "ami-0324bce2436ce02b2"
  instance_type           = "t3.micro"
  vpc_security_group_ids  = [aws_security_group.wordpress_sg.id]
  key_name                = aws_key_pair.wordpress_keypair.key_name
  associate_public_ip_address = true
  iam_instance_profile        = aws_iam_instance_profile.wordpress_profile.name

  user_data = templatefile("${path.module}/user_data.sh", {
    db_pass = var.database_password
   })
}

data "aws_iam_policy_document" "wordpress_assume_role" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "wordpress_role" {
  name               = "wordpress-role"
  assume_role_policy = data.aws_iam_policy_document.wordpress_assume_role.json
}

resource "aws_iam_role_policy_attachment" "wordpress_ssm" {
  role       = aws_iam_role.wordpress_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

resource "aws_iam_instance_profile" "wordpress_profile" {
  name = "wordpress-profile"
  role = aws_iam_role.wordpress_role.name
}

resource "aws_key_pair" "wordpress_keypair" {
  key_name   = "wordpress-key"
  public_key = file(var.public_key_path)
}

resource "aws_security_group" "wordpress_sg" {
  name        = "wordpress-sg"
  description = "Security group for Wordpress EC2 instance"

  tags = {
    Name        = "wordpress-sg"
    Project     = "wordpress"
    Environment = "dev"
    ManagedBy   = "terraform"
  }
}

resource "aws_vpc_security_group_ingress_rule" "wordpress_http" {
  security_group_id = aws_security_group.wordpress_sg.id

  cidr_ipv4   = "0.0.0.0/0"
  from_port   = 80
  ip_protocol = "tcp"
  to_port     = 80
}

resource "aws_vpc_security_group_ingress_rule" "wordpress_ssh" {
  security_group_id = aws_security_group.wordpress_sg.id

  cidr_ipv4   = var.my_ip
  from_port   = 22
  ip_protocol = "tcp"
  to_port     = 22
}

resource "aws_vpc_security_group_egress_rule" "wordpress_egress_all" {
  security_group_id = aws_security_group.wordpress_sg.id

  cidr_ipv4   = "0.0.0.0/0"
  from_port   = -1
  ip_protocol = "-1"
  to_port     = -1
}