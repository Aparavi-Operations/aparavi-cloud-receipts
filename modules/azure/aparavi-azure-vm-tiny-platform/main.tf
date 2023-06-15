locals {
  createrg  = var.resource_group_name == ""
  createnet = var.resource_group_name == "" || var.virtual_network_name == "" || var.subnet_name == "" || var.db_subnet_name == ""
}

data "azurerm_subscription" "current" {}

data "azurerm_resource_group" "main" {
  count = local.createrg ? 0 : 1
  name  = local.createrg ? "dummy" : var.resource_group_name
}

data "azurerm_virtual_network" "main" {
  count               = local.createnet ? 0 : 1
  name                = local.createnet ? "dummy" : var.virtual_network_name
  resource_group_name = local.createnet ? "dummy" : var.resource_group_name
}

data "azurerm_subnet" "main" {
  count                = local.createnet ? 0 : 1
  name                 = local.createnet ? "dummy" : var.subnet_name
  virtual_network_name = local.createnet ? "dummy" : var.virtual_network_name
  resource_group_name  = local.createnet ? "dummy" : var.resource_group_name
}

data "azurerm_subnet" "db" {
  count                = local.createnet ? 0 : 1
  name                 = local.createnet ? "dummy" : var.db_subnet_name
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
  component = "platfrom"

  resource_group_location = local.createrg ? join("", azurerm_resource_group.main[*].location) : join("", data.azurerm_resource_group.main[*].location)
  resource_group_name     = local.createrg ? join("", azurerm_resource_group.main[*].name) : var.resource_group_name
  virtual_network_id      = local.createnet ? join("", module.network[*].virtual_network_id) : join("", data.azurerm_virtual_network.main[*].id)
  vm_subnet               = local.createnet ? join("", module.network[*].public_subnet) : join("", data.azurerm_subnet.main[*].id)
  db_subnet               = local.createnet ? join("", module.network[*].db_subnet) : join("", data.azurerm_subnet.db[*].id)
  vm_size                 = var.platfrom_node_size
  ssh_key                 = var.ssh_key
  disk_size               = var.platfrom_disk_size
  init_repo               = var.platfrom_init_repo
  init_repo_org           = var.platfrom_init_repo_org
  init_repo_branch        = var.platfrom_init_repo_branch
  init_script             = var.platfrom_init_script
  client_name             = var.client_name
  logstash_endpoint       = var.logstash_endpoint
  fw_ports                = var.platfrom_fw_ports
  db_shape                = var.db_shape
  db_size                 = var.db_size
  db_username             = var.db_username
  db_password             = var.db_password
  tags                    = var.tags
  gh_token                = var.gh_token
}
