/* ============================================

  Please adjust VALUES.TF in order to
  provide correct configuration for deployment

=============================================== */

module "network" {
  source         = "./modules/network"
  deployment_tag = var.DEPLOYMENT
}

module "appagent" {
  source             = "./modules/appagent"
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

module "monitoring" {
  source             = "../monitoring"
  key_name           = var.KEY_NAME
  management_network = var.MANAGEMENT_NETWORK
  deployment_name    = var.DEPLOYMENT
  network_vpc_id     = module.network.vpc_id
  vm_subnet_id       = module.network.vm_subnet_id
}
