resource "azurerm_resource_group" "this" {
  name     = var.name
  location = var.location
  tags     = var.tags
}

module "network" {
  source = "Azure/network/azurerm"

  resource_group_name = azurerm_resource_group.this.name
  address_space       = "10.0.0.0/16"
  subnet_prefixes     = ["10.0.1.0/24"]
  subnet_names        = [var.name]
  tags                = var.tags

  depends_on = [azurerm_resource_group.this]
}

module "aks" {
  source = "Azure/aks/azurerm"

  resource_group_name             = azurerm_resource_group.this.name
  tags                            = var.tags
  prefix                          = "aks"
  cluster_name                    = var.name
  network_plugin                  = "azure"
  vnet_subnet_id                  = module.network.vnet_subnets[0]
  os_disk_size_gb                 = 50
  sku_tier                        = "Paid"
  enable_http_application_routing = true
  enable_azure_policy             = true
  enable_auto_scaling             = true
  agents_min_count                = 2
  agents_max_count                = 2
  agents_count                    = null
  agents_max_pods                 = 100
  agents_pool_name                = "default"
  agents_availability_zones       = ["1", "2"]
  agents_type                     = "VirtualMachineScaleSets"
  agents_size                     = var.aks_agents_size

  agents_labels = {
    "nodepool" : "defaultnodepool"
  }

  agents_tags = {
    "Agent" : "defaultnodepoolagent"
  }

  network_policy                 = "azure"
  net_profile_dns_service_ip     = "10.0.2.2"
  net_profile_docker_bridge_cidr = "170.10.0.1/16"
  net_profile_service_cidr       = "10.0.2.0/24"

  depends_on = [module.network]
}

module "mysql" {
  source = "./modules/mysql"

  resource_group_name = azurerm_resource_group.this.name
  name                = var.name
  location            = var.location
  tags                = var.tags
  sku_name            = var.mysql_sku_name
  subnet_id           = module.network.vnet_subnets[0]

  depends_on = [module.network]
}

provider "helm" {
  kubernetes {
    host                   = module.aks.host
    cluster_ca_certificate = base64decode(module.aks.cluster_ca_certificate)
    client_key             = base64decode(module.aks.client_key)
    client_certificate     = base64decode(module.aks.client_certificate)
  }
}

provider "kubernetes" {
  host                   = module.aks.host
  cluster_ca_certificate = base64decode(module.aks.cluster_ca_certificate)
  client_key             = base64decode(module.aks.client_key)
  client_certificate     = base64decode(module.aks.client_certificate)
}

locals {
  aggregator_node_name = coalesce(
    var.aggregator_node_name,
    "${var.name}-aggregator"
  )
  collector_node_name = coalesce(
    var.collector_node_name,
    "${var.name}-collector"
  )
}

module "aparavi" {
  source = "../../helm"

  name                 = "aparavi"
  chart_version        = var.aparavi_chart_version
  mysql_hostname       = module.mysql.address
  mysql_username       = module.mysql.username
  mysql_password       = module.mysql.password
  platform_host        = var.platform_host
  platform_node_id     = var.platform_node_id
  aggregator_node_name = local.aggregator_node_name
  collector_node_name  = local.collector_node_name
  generate_sample_data = var.generate_sample_data

  depends_on = [module.aks, module.mysql]
}