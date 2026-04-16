variable "ami_id" {
  description = "AMI ID to use for the instance"
  type        = string
  default     = "ami-0324bce2436ce02b2"
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.micro"
}

variable "security_group_id" {
  description = "Security group ID"
  type        = string
}

variable "public_key_path" {
  description = "Path to the public key file"
  type        = string
}

variable "iam_instance_profile" {
  description = "IAM instance profile name"
  type        = string
}

variable "database_password" {
  description = "Password for MariaDB"
  type        = string
  sensitive   = true
}

variable "associate_public_ip" {
  description = "Whether to associate a public IP"
  type        = bool
  default     = true
}