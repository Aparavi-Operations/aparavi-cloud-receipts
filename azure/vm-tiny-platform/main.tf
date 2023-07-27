module "aparavi-azure-vm" {
  source = "../../modules/azure/aparavi-azure-vm-tiny-platform"

  name                 = var.name
  vnet_cidr            = var.vnet_cidr
  location             = var.location
  db_shape             = var.db_shape
  db_username          = var.db_username
  db_password          = var.db_password
  platfrom_node_size   = var.platfrom_size
  platfrom_disk_size   = var.platfrom_disk_size
  platfrom_fw_ports    = var.platfrom_fw_ports
  ssh_key              = var.ssh_key
  tags                 = var.tags
  client_name          = var.client_name
  logstash_endpoint    = var.logstash_endpoint
  resource_group_name  = var.resource_group_name
  virtual_network_name = var.virtual_network_name
  subnet_name          = var.subnet_name
  db_subnet_name       = var.db_subnet_name
  gh_token             = var.gh_token
}
