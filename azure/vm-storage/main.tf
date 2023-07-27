module "aparavi-azure-vm" {
  source = "../../modules/azure/aparavi-azure-vm-storage"

  name                   = var.name
  vnet_cidr              = var.vnet_cidr
  location               = var.location
  share_node_size       = var.size
  share_disk_size       = var.disk_size
  share_fw_ports = var.fw_ports
  ssh_key                = var.ssh_key
  tags                   = var.tags
  resource_group_name   = var.resource_group_name
  virtual_network_name  = var.virtual_network_name
  subnet_name           = var.subnet_name
}
