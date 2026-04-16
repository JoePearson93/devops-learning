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