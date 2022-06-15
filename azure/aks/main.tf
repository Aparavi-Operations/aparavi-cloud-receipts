module "aparavi-aks" {
  source = "../../modules/azure/aparavi-aks"

  name                 = var.name
  location             = var.location
  tags                 = var.tags
  aks_agents_size      = var.aks_agents_size
  mysql_sku_name       = var.mysql_sku_name
  platform_host        = var.platform_host
  platform_node_id     = var.platform_node_id
  appagent_node_name   = var.appagent_node_name
  generate_sample_data = var.generate_sample_data
}
