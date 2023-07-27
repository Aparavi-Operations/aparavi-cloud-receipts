module "aparavi-azure-vm" {
  source = "../../modules/azure/aparavi-azure-vm-tiny"

  name                   = var.name
  vnet_cidr              = var.vnet_cidr
  location               = var.location
  db_shape               = var.db_shape
  db_username                = var.db_username
  db_password            = var.db_password
  appagt_node_size       = var.appagt_size
  appagt_disk_size       = var.appagt_disk_size
  appagt_fw_ports = var.appagt_fw_ports
  ssh_key                = var.ssh_key
  tags                   = var.tags
  client_name           = var.client_name
  parent_object         = var.parent_object
  platform_endpoint     = var.platform_endpoint
  logstash_endpoint     = var.logstash_endpoint
  resource_group_name   = var.resource_group_name
  virtual_network_name  = var.virtual_network_name
  subnet_name           = var.subnet_name
  db_subnet_name           = var.db_subnet_name
}
