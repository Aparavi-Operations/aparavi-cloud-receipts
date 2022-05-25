module "network" {
  source = "../modules/network"

  name                 = var.name
  tags                 = var.tags
  cidr                 = var.vpc_cidr
  private_subnet_cidrs = var.vpc_private_subnet_cidrs
  public_subnet_cidrs  = var.vpc_public_subnet_cidrs
}

module "eks" {
  source = "./modules/eks"

  name           = var.name
  tags           = var.tags
  subnet_ids     = module.network.private_subnet_ids
  instance_types = var.eks_instance_types

  depends_on = [module.network]
}

module "rds" {
  source = "../modules/rds"

  name                  = var.name
  tags                  = var.tags
  instance_class        = var.rds_instance_class
  allocated_storage     = var.rds_allocated_storage
  max_allocated_storage = var.rds_max_allocated_storage
  subnet_ids            = module.network.private_subnet_ids
  vpc_id                = module.network.vpc_id
  sg_cidr_blocks        = var.vpc_private_subnet_cidrs

  depends_on = [module.network]
}

data "aws_eks_cluster_auth" "cluster" {
  name = module.eks.cluster_id
}

data "aws_eks_cluster" "cluster" {
  name = module.eks.cluster_id
}

provider "helm" {
  kubernetes {
    host  = data.aws_eks_cluster.cluster.endpoint
    token = data.aws_eks_cluster_auth.cluster.token
    cluster_ca_certificate = base64decode(
      data.aws_eks_cluster.cluster.certificate_authority[0].data
    )
  }
}

provider "kubernetes" {
  host  = data.aws_eks_cluster.cluster.endpoint
  token = data.aws_eks_cluster_auth.cluster.token
  cluster_ca_certificate = base64decode(
    data.aws_eks_cluster.cluster.certificate_authority[0].data
  )
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
  mysql_hostname       = module.rds.address
  mysql_username       = module.rds.username
  mysql_password       = module.rds.password
  platform_host        = var.platform_host
  platform_node_id     = var.platform_node_id
  aggregator_node_name = local.aggregator_node_name
  collector_node_name  = local.collector_node_name
  generate_sample_data = var.generate_sample_data

  depends_on = [module.eks, module.rds]
}
