variable "vms_name" {
  type        = string
  description = "Name of the virtual machine"
}

variable "vms_cores" {
  type        = number
  default     = 2
  description = "Number of vCPU cores"
}

variable "vms_memory" {
  type        = number
  default     = 2
  description = "RAM size in GB"
}

variable "vms_disk_size" {
  type        = number
  default     = 10
  description = "Boot disk size in GB"
}

variable "vms_disk_type" {
  type        = string
  default     = "network-ssd"
  description = "Boot disk type"
}

variable "vms_disk_name" {
  type        = string
  default     = null
  description = "Boot disk name. Defaults to <vm name>-disk"
}

variable "vms_disk_zone" {
  type        = string
  default     = "ru-central1-a"
  description = "Zone of the virtual machine and its boot disk"
}

variable "vms_disk_image_id" {
  type        = string
  default     = null
  description = "Boot image id. When null, vms_image_family is used"
}

variable "vms_image_family" {
  type        = string
  default     = "ubuntu-2204-lts"
  description = "Image family used when vms_disk_image_id is not set"
}

variable "vms_disk_labels" {
  type        = map(string)
  default     = {}
  description = "Labels for the virtual machine and its boot disk"
}

variable "subnet_id" {
  type        = string
  description = "Subnet id from the network module"
}

variable "security_group_ids" {
  type        = list(string)
  default     = null
  description = "Security groups for the network interface. Omit to keep the network default group."
}

variable "ssh_public_key" {
  type        = string
  description = "Public key for the ubuntu user"
}
