output "vm_dev_name" {
  value       = module.vm_dev.vms_name
  description = "Name of the dev virtual machine"
}

output "vm_dev_address" {
  value       = module.vm_dev.vms_public_ip
  description = "Public address of the dev virtual machine"
}

output "vm_prod_name" {
  value       = module.vm_prod.vms_name
  description = "Name of the prod virtual machine"
}

output "vm_prod_address" {
  value       = module.vm_prod.vms_public_ip
  description = "Public address of the prod virtual machine"
}

output "prod_security_group_id" {
  value       = module.network.vps_security_group_id
  description = "Id of the prod security group"
}

output "prod_security_group_name" {
  value       = module.network.vps_security_group_name
  description = "Name of the prod security group"
}
