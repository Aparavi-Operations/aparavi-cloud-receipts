module "aparavi-ec2" {
  source = "../../modules/aws/aparavi-ec2-tiny-platform"

  name                    = var.name
  key_name                = var.key_name
  platform_mysql_password = var.db_password
  platform_instance_type  = "c6a.2xlarge"
  tags                    = var.tags
  logstash_endpoint       = var.logstash_endpoint
  subnet_id               = var.subnet_id
  db_subnet_ids           = var.db_subnet_ids
  db_subnet_group         = var.db_subnet_group
  platform_elastic_ip     = var.elastic_ip
  gh_token                = var.gh_token
}
