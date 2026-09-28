module "vm_dev" {
  source = "./modules/vms"

  vms_name = "vm-dev"
  vms_disk_labels = {
    environment = "dev"
  }
  subnet_id          = module.network.vps_subnet_id
  security_group_ids = [module.network.vps_security_group_id]
  ssh_public_key     = var.ssh_public_key
}
