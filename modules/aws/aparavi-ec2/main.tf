/* ============================================

  Please adjust VALUES.TF in order to
  provide correct configuration for deployment

=============================================== */

module "network" {
  source         = "./modules/network"
  deployment_tag = var.DEPLOYMENT
}

module "aggregator" {
  source             = "./modules/aggregator"
  key_name           = var.KEY_NAME
  management_network = var.MANAGEMENT_NETWORK
  platform           = var.PLATFORM
  parent_id          = var.PARENT_ID
  deployment_tag     = var.DEPLOYMENT
  network_vpc_id     = module.network.vpc_id
  vm_subnet_id       = module.network.vm_subnet_id
  rds_subnet_id_a    = module.network.rds_subnet_id_a
  rds_subnet_id_b    = module.network.rds_subnet_id_b
}

module "collector" {
  source                = "./modules/collector"
  key_name              = var.KEY_NAME
  management_network    = var.MANAGEMENT_NETWORK
  deployment_tag        = var.DEPLOYMENT
  network_vpc_id        = module.network.vpc_id
  vm_subnet_id          = module.network.vm_subnet_id
  aggregator_private_ip = module.aggregator.private_ip
}

module "monitoring" {
  source             = "./modules/monitoring"
  key_name           = var.KEY_NAME
  management_network = var.MANAGEMENT_NETWORK
  deployment_tag     = var.DEPLOYMENT
  network_vpc_id     = module.network.vpc_id
  vm_subnet_id       = module.network.vm_subnet_id
}