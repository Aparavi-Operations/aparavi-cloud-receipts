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
  instance_count        = var.collector_instance_count
  key_name              = var.KEY_NAME
  management_network    = var.MANAGEMENT_NETWORK
  deployment_tag        = var.DEPLOYMENT
  network_vpc_id        = module.network.vpc_id
  vm_subnet_id          = module.network.vm_subnet_id
  aggregator_private_ip = module.aggregator.private_ip
}

module "monitoring" {
  source             = "../../../modules/monitoring"
  key_name           = var.KEY_NAME
  management_network = var.MANAGEMENT_NETWORK
  deployment_name    = var.DEPLOYMENT
  network_vpc_id     = module.network.vpc_id
  vm_subnet_id       = module.network.public_subnet_id
}

module "bastion" {
  source = "./modules/bastion"

  deployment_tag = var.DEPLOYMENT
  vpc_id         = module.network.vpc_id
  subnet_id      = module.network.public_subnet_id
  sg_cidr_blocks = var.MANAGEMENT_NETWORK
  key_name       = var.KEY_NAME
}
