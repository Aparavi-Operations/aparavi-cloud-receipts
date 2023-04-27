module "network" {
  source   = "./modules/network"
  name     = var.name
  vpc_cidr = var.vpc_cidr
  tags     = var.tags
}

module "appagt" {
  source              = "./modules/host"
  name                = var.name
  vpc_id              = module.network.vpc_id
  subnet_id           = module.network.public_subnet_id
  associate_public_ip = true
  instance_type       = var.appagt_instance_type
  root_size           = var.appagt_root_size
  subcomponent        = "appagt"
  init_repo           = var.appagt_init_repo
  init_repo_org       = var.appagt_init_repo_org
  init_repo_branch    = var.appagt_init_repo_branch
  init_script         = var.appagt_init_script
  init_options        = var.appagt_init_options != "" ? var.appagt_init_options : "-n appagt -c ${var.client_name} -p '${var.appagt_mysql_password}' -o ${var.parent_object} -h ${module.appagt-rds.connect_address} -m ${var.appagt_mysql_username}"
  key_name            = var.key_name

  tags = var.tags
}

module "appagt-rds" {
  source              = "./modules/rds"
  name                = var.name
  vpc_id              = module.network.vpc_id
  subcomponent        = "appagt"
  subnet_ids          = module.network.rds_subnet_ids
  size                = var.appagt_db_size
  mysql_version       = var.appagt_mysql_version
  multi_az            = var.appagt_rds_multi_az
  mysql_port          = var.appagt_mysql_port
  mysql_username      = var.appagt_mysql_username
  mysql_password      = var.appagt_mysql_password
  mysql_instance_type = var.appagt_mysql_instance_type

  tags = var.tags
}
