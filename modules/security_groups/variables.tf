variable "my_ip" {
  description = "My public IP address for SSH access"
  type        = string
}

variable "open_cidr" {
  description = "CIDR block open to the public"
  type        = string
  default     = "0.0.0.0/0"
}

variable "project_name" {
  description = "Project name used for resource naming"
  type        = string
  default     = "wordpress"
}