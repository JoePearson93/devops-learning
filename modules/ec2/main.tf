resource "aws_instance" "wordpress" {
  ami                         = var.ami_id
  instance_type               = var.instance_type
  vpc_security_group_ids      = [var.security_group_id]
  key_name                    = aws_key_pair.wordpress_keypair.key_name
  associate_public_ip_address = var.associate_public_ip
  iam_instance_profile        = var.iam_instance_profile

  user_data = templatefile("${path.module}/user_data.sh", {
    db_pass = var.database_password
  })
  user_data_replace_on_change = true

  tags = {
    Name        = "wordpress-ec2"
    Project     = "wordpress"
    Environment = "dev"
    ManagedBy   = "terraform"
  }
}

resource "aws_key_pair" "wordpress_keypair" {
  key_name   = "wordpress-key"
  public_key = file(var.public_key_path)
}