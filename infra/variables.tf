variable "cloud_id" {
  type        = string
  description = "Yandex Cloud id"
}

variable "folder_id" {
  type        = string
  description = "Yandex Cloud folder id"
}

variable "ssh_public_key" {
  type        = string
  description = "Public key installed on the virtual machines for the ubuntu user. CI decodes SSH_PUBLIC_KEY into TF_VAR_ssh_public_key."
}
