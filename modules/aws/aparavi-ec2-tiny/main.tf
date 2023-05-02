locals {
  createnet = ! (var.subnet_id != "" && (var.db_subnet_ids != [] || var.db_subnet_group != ""))
  creategroup = local.createnet || var.db_subnet_group == ""
}

module "network" {
  count    = local.createnet ? 1 : 0
  source   = "./modules/network"
  name     = var.name
  vpc_cidr = var.vpc_cidr
  tags     = var.tags
}

data "aws_subnet" "selected" {
  count = local.createnet ? 0 : 1
  id    = var.subnet_id
}

resource "aws_db_subnet_group" "rds_subnet_group" {
  count = local.creategroup ? 1 : 0
  name       = var.name
  subnet_ids = local.createnet ? flatten(module.network[*].rds_subnet_ids) : var.db_subnet_ids

  tags = merge(var.tags, {
    Name         = var.name
  })
}

module "appagt" {
  source              = "./modules/host"
  name                = var.name
  vpc_id              = local.createnet ? join("", module.network[*].vpc_id) : join("", data.aws_subnet.selected[*].vpc_id)
  subnet_id           = local.createnet ? join("", module.network[*].public_subnet_id) : var.subnet_id
  associate_public_ip = true
  instance_type       = var.appagt_instance_type
  root_size           = var.appagt_root_size
  component           = "appagt"
  init_repo           = var.appagt_init_repo
  init_repo_org       = var.appagt_init_repo_org
  init_repo_branch    = var.appagt_init_repo_branch
  init_script         = var.appagt_init_script
  init_options        = var.appagt_init_options != "" ? var.appagt_init_options : "-n appagt -c ${var.client_name} -p '${var.appagt_mysql_password}' -o ${var.parent_object} -h ${module.appagt-rds.connect_address} -m ${var.appagt_mysql_username} -a ${var.platform_endpoint} -l ${var.logstash_endpoint}"
  key_name            = var.key_name
  elastic_ip          = var.appagt_elastic_ip

  tags = var.tags
}

module "appagt-rds" {
  source              = "./modules/rds"
  name                = var.name
  vpc_id              = local.createnet ? join("", module.network[*].vpc_id) : join("", data.aws_subnet.selected[*].vpc_id)
  component           = "appagt"
  subnet_group        = local.creategroup ? join("", aws_db_subnet_group.rds_subnet_group[*].id) : var.db_subnet_group
  size                = var.appagt_db_size
  mysql_version       = var.appagt_mysql_version
  multi_az            = var.appagt_rds_multi_az
  mysql_port          = var.appagt_mysql_port
  mysql_username      = var.appagt_mysql_username
  mysql_password      = var.appagt_mysql_password
  mysql_instance_type = var.appagt_mysql_instance_type

  tags = var.tags
}
