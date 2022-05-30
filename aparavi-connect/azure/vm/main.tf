module "aparavi-azure-vm" {
  source = "../../../modules/azure/aparavi-azure-vm"

  name                   = var.name
  appagent               = true
  vnet_cidr              = var.vnet_cidr
  location               = var.location
  platform               = var.platform
  parent_id              = var.parent_id
  bastion_size           = var.bastion_size
  db_shape               = var.db_shape
  collector_storage_size = var.collector_storage_size
  db_user                = var.db_user
  db_password            = var.db_password
  node_size              = var.node_size
  monitoring_size        = var.monitoring_size
  monitoring_role_name   = var.monitoring_role_name
  ssh_key                = var.ssh_key
  tags                   = var.tags
}
