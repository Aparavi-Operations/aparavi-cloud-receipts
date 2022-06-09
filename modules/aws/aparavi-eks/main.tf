data "aws_availability_zones" "available" {
  count = length(var.azs) > 0 ? 0 : 1
}

locals {
  azs = (
    length(var.azs) > 0 ?
    var.azs :
    data.aws_availability_zones.available[0].names
  )
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 3.14.0"

  name               = var.name
  tags               = var.tags
  cidr               = var.vpc_cidr
  azs                = local.azs
  private_subnets    = var.vpc_private_subnet_cidrs
  public_subnets     = var.vpc_public_subnet_cidrs
  enable_nat_gateway = true
  single_nat_gateway = true
}

module "eks" {
  source = "./modules/eks"

  name           = var.name
  tags           = var.tags
  subnet_ids     = module.vpc.private_subnets
  instance_types = var.eks_instance_types

  depends_on = [module.vpc]
}

module "rds" {
  source  = "terraform-aws-modules/rds/aws"
  version = "~> 4.3.0"

  identifier                = var.name
  tags                      = var.tags
  engine                    = "mysql"
  engine_version            = "8.0.28"
  allocated_storage         = var.rds_allocated_storage
  max_allocated_storage     = var.rds_max_allocated_storage
  instance_class            = var.rds_instance_class
  username                  = "aggregator"
  vpc_security_group_ids    = [aws_security_group.allow_mysql.id]
  subnet_ids                = module.vpc.private_subnets
  create_db_subnet_group    = true
  db_subnet_group_name      = var.name
  create_db_option_group    = false
  create_db_parameter_group = false
  apply_immediately         = true
  skip_final_snapshot       = true

  depends_on = [module.vpc]
}

resource "aws_security_group" "allow_mysql" {
  name        = "allow-mysql"
  description = "Allow MySQL inbound traffic"
  vpc_id      = module.vpc.vpc_id

  ingress {
    description = "MySQL from VPC"
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = var.vpc_private_subnet_cidrs
  }

  tags = merge(
    var.tags,
    { "Name" = "allow-mysql" },
  )
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
  source = "../../aparavi-helm"

  name                 = "aparavi"
  chart_version        = var.aparavi_chart_version
  mysql_hostname       = module.rds.db_instance_address
  mysql_username       = module.rds.db_instance_username
  mysql_password       = module.rds.db_instance_password
  platform_host        = var.platform_host
  platform_node_id     = var.platform_node_id
  aggregator_node_name = local.aggregator_node_name
  collector_node_name  = local.collector_node_name
  generate_sample_data = var.generate_sample_data

  depends_on = [module.eks, module.rds]
}
