module "vm_prod" {
  source = "./modules/vms"

  vms_name = "vm-prod"
  vms_disk_labels = {
    environment = "prod"
  }
  subnet_id          = module.network.vps_subnet_id
  security_group_ids = [module.network.vps_security_group_id]
  ssh_public_key     = var.ssh_public_key
}
