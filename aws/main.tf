module "network" {
  source = "./modules/network"
}

module "aggregator" {
  source = "./modules/aggregator"
  network_vpc_id = module.network.vpc_id
  management_network = var.MANAGEMENT_NETWORK
  aggregator_instance_type = var.AGGREGATOR_INSTANCE_TYPE
}

/*module "collector" {
  source  = "./modules/collector"
}

module "monitoring" {
  source  = "./modules/monitoring"
}*/