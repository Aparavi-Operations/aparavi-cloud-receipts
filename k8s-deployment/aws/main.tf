data "aws_availability_zones" "available" {}

module "network" {
  source          = "./modules/network"
  name            = var.name
  cidr            = var.vpc_cidr
  private_subnets = var.vpc_private_subnets
  public_subnets  = var.vpc_public_subnets
  azs             = data.aws_availability_zones.available.names
}

module "eks" {
  source                         = "./modules/eks"
  name                           = var.name
  master_version                 = "1.22"
  cluster_endpoint_public_access = var.eks_cluster_endpoint_public_access
  subnet_ids                     = module.network.private_subnet_ids
  instance_types                 = var.eks_instance_types
  min_size                       = var.eks_min_size
  max_size                       = var.eks_max_size
  desired_size                   = var.eks_desired_size
  depends_on                     = [module.network]
}

module "rds" {
  source              = "./modules/rds"
  apply_immediately   = var.rds_apply_immediately
  skip_final_snapshot = var.rds_skip_final_snapshot
  name                = var.name
  instance_class      = var.rds_instance_class
  allocated_storage   = var.rds_allocated_storage
  username            = "aggregator"
  db_name             = "aggregator"
  subnet_ids          = module.network.private_subnet_ids
  vpc_id              = module.network.vpc_id
  sg_cidr_blocks      = var.vpc_private_subnets
  depends_on          = [module.network]
}

module "aparavi" {
  source               = "../modules/aparavi-helm"
  name                 = "aparavi"
  mysql_hostname       = module.rds.db_instance_address
  mysql_password       = module.rds.db_instance_password
  platform_host        = var.platform_host
  platform_node_id     = var.platform_node_id
  aggregator_node_name = var.aggregator_node_name
  collector_node_name  = var.collector_node_name
  generate_sample_data = var.generate_sample_data
  depends_on           = [module.eks, module.rds]
}
