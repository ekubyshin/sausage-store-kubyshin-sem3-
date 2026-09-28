terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
}

data "yandex_compute_image" "boot" {
  family = var.vms_image_family
}

resource "yandex_compute_disk" "boot" {
  name     = coalesce(var.vms_disk_name, "${var.vms_name}-disk")
  type     = var.vms_disk_type
  zone     = var.vms_disk_zone
  size     = var.vms_disk_size
  image_id = coalesce(var.vms_disk_image_id, data.yandex_compute_image.boot.id)
  labels   = var.vms_disk_labels
}

resource "yandex_compute_instance" "vps" {
  name                      = var.vms_name
  platform_id               = "standard-v3"
  zone                      = var.vms_disk_zone
  allow_stopping_for_update = true

  labels = var.vms_disk_labels

  resources {
    cores  = var.vms_cores
    memory = var.vms_memory
  }

  boot_disk {
    disk_id = yandex_compute_disk.boot.id
  }

  network_interface {
    subnet_id          = var.subnet_id
    nat                = true
    security_group_ids = var.security_group_ids
  }

  metadata = {
    ssh-keys = "ubuntu:${var.ssh_public_key}"
  }
}
