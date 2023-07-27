locals {
  createrg  = var.resource_group_name == ""
  createnet = var.resource_group_name == "" || var.virtual_network_name == "" || var.subnet_name == ""
}

data "azurerm_subscription" "current" {}

data "azurerm_resource_group" "main" {
  count = local.createrg ? 0 : 1
  name  = local.createrg ? "dummy" : var.resource_group_name
}

data "azurerm_subnet" "main" {
  count                = local.createnet ? 0 : 1
  name                 = local.createnet ? "dummy" : var.subnet_name
  virtual_network_name = local.createnet ? "dummy" : var.virtual_network_name
  resource_group_name  = local.createnet ? "dummy" : var.resource_group_name
}

resource "azurerm_resource_group" "main" {
  count    = local.createrg ? 1 : 0
  name     = var.name
  location = var.location
}

module "network" {
  count                   = local.createnet ? 1 : 0
  source                  = "./modules/network"
  name                    = var.name
  vnet_cidr               = var.vnet_cidr
  resource_group_location = local.createrg ? join("", azurerm_resource_group.main[*].location) : join("", data.azurerm_resource_group.main[*].location)
  resource_group_name     = local.createrg ? join("", azurerm_resource_group.main[*].name) : var.resource_group_name
  tags                    = var.tags
}

module "node" {
  source    = "./modules/node"
  name      = var.name
  component = "fileshare"

  resource_group_location = local.createrg ? join("", azurerm_resource_group.main[*].location) : join("", data.azurerm_resource_group.main[*].location)
  resource_group_name     = local.createrg ? join("", azurerm_resource_group.main[*].name) : var.resource_group_name
  vm_subnet               = local.createnet ? join("", module.network[*].public_subnet) : join("", data.azurerm_subnet.main[*].id)
  vm_size                 = var.share_node_size
  ssh_key                 = var.ssh_key
  disk_size               = var.share_disk_size
  fw_ports = var.share_fw_ports
  tags = var.tags
}
