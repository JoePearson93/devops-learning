variable "instance_name" {
  description = "Name tag for the EC2 instance"
  type        = string
  default     = "wordpress-instance"
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.micro"
}

variable "ami_id" {
  description = "AMI ID to use for the instance"
  type        = string
  default     = "ami-0324bce2436ce02b2"
}

variable "http_port" {
  description = "Port for HTTP access"
  type        = number
  default     = 80
}

variable "ssh_port"{
  description = "Port for SSH access"
  type        = number
  default     = 22 
}

variable "open_cidr" {
  type        = string
  description = "CIDR block open to the public"
  default     = "0.0.0.0/0"
}

variable "region" {
  description = "AWS region where resources will be created"
  type        = string
  default     = "eu-west-1"
}

variable "key_name" {
  type       = string
  default     = null
  description = "Optional EC2 key pair name"
}

variable "project_name"{
  description = "Project name used for resource naming"
  type        = string
  default     = "wordpress"
}

variable "database_password" {
  type        = string
  description = "Password for the MariaDB"
  sensitive   = true
}

variable "my_ip" {
  type        = string
  description = "My public IP address for SSH access"
}

variable "public_key_path" {
  type        = string
  description = "Path to the public key file"
  default     = "~/.ssh/wordpress-key.pub"
}

variable "userdata_file" {
  type        = string
  description = "Path to the user data script"
  default     = "user_data.sh"
}

variable "tags" {
  description = "common tags for all resources"
  type        = map(string)
  default     = {
    Environment = "dev"
    ManagedBy   = "terraform"
    Project     = "wordpress"
  }
}

variable "associate_public_ip" {
  type        = bool
  description = "Whether to associate a public IP with the instance"
  default     = true
}