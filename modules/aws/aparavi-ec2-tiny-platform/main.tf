locals {
  createnet   = !(var.subnet_id != "" && (var.db_subnet_ids != [] || var.db_subnet_group != ""))
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
  count      = local.creategroup ? 1 : 0
  name       = var.name
  subnet_ids = local.createnet ? flatten(module.network[*].rds_subnet_ids) : var.db_subnet_ids

  tags = merge(var.tags, {
    Name = var.name
  })
}

module "platform" {
  source              = "./modules/host"
  name                = var.name
  vpc_id              = local.createnet ? join("", module.network[*].vpc_id) : join("", data.aws_subnet.selected[*].vpc_id)
  subnet_id           = local.createnet ? join("", module.network[*].public_subnet_id) : var.subnet_id
  associate_public_ip = true
  instance_type       = var.platform_instance_type
  root_size           = var.platform_root_size
  component           = "platform"
  init_repo           = var.platform_init_repo
  init_repo_org       = var.platform_init_repo_org
  init_repo_branch    = var.platform_init_repo_branch
  init_script         = var.platform_init_script
  init_options        = var.platform_init_options != "" ? var.platform_init_options : "-n platform-only -h ${module.platform-rds.connect_address} -f ${var.platform_mysql_port} -m ${var.platform_mysql_username} -j '${var.platform_mysql_password}' -p ${var.fqdn_address} -t ${var.gh_token}"
  key_name            = var.key_name
  elastic_ip          = var.platform_elastic_ip
  gh_token            = var.gh_token

  tags = var.tags
}

module "platform-rds" {
  source              = "./modules/rds"
  name                = var.name
  vpc_id              = local.createnet ? join("", module.network[*].vpc_id) : join("", data.aws_subnet.selected[*].vpc_id)
  component           = "platform"
  subnet_group        = local.creategroup ? join("", aws_db_subnet_group.rds_subnet_group[*].id) : var.db_subnet_group
  size                = var.platform_db_size
  mysql_version       = var.platform_mysql_version
  multi_az            = var.platform_rds_multi_az
  mysql_port          = var.platform_mysql_port
  mysql_username      = var.platform_mysql_username
  mysql_password      = var.platform_mysql_password
  mysql_instance_type = var.platform_mysql_instance_type

  tags = var.tags
}
