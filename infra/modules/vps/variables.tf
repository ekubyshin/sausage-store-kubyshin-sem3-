variable "vps_network_name" {
  type        = string
  default     = "sausage-store-network"
  description = "Name of the VPC network"
}

variable "vps_security_group_name" {
  type        = string
  default     = "sausage-store-security-group"
  description = "Name of the security group"
}

variable "vps_subnet_name" {
  type        = string
  default     = "sausage-store-subnet-a"
  description = "Name of the subnet"
}

variable "vps_zone" {
  type        = string
  default     = "ru-central1-a"
  description = "Zone of the subnet"
}

variable "vps_subnet_cidr" {
  type        = string
  default     = "10.10.0.0/24"
  description = "CIDR block of the subnet"
}
