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