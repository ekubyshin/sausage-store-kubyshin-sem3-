output "vps_network_id" {
  value       = yandex_vpc_network.store_net.id
  description = "Id of the VPC network"
}

output "vps_subnet_id" {
  value       = yandex_vpc_subnet.store_subnet.id
  description = "Id of the subnet for virtual machines"
}

output "vps_security_group_id" {
  value       = yandex_vpc_security_group.store_net_group.id
  description = "Id of the security group"
}

output "vps_security_group_name" {
  value       = yandex_vpc_security_group.store_net_group.name
  description = "Name of the security group"
}

output "vps_name" {
  value       = yandex_vpc_network.store_net.name
  description = "Name of the VPC network"
}
