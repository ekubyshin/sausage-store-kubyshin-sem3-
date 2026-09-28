output "vms_id" {
  value       = yandex_compute_instance.vps.id
  description = "id of vps"
}

output "vms_name" {
  value       = yandex_compute_instance.vps.name
  description = "name of vps"
}

output "vms_private_ip" {
  value       = yandex_compute_instance.vps.network_interface[0].ip_address
  description = "private ip of vps"
}

output "vms_public_ip" {
  value       = yandex_compute_instance.vps.network_interface[0].nat_ip_address
  description = "public ip of vps"
}