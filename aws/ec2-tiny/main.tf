module "aparavi-ec2" {
  source = "../../modules/aws/aparavi-ec2-tiny"

  name                  = var.name
  key_name              = var.key_name
  appagt_mysql_password = var.db_password
  appagt_instance_type  = "c6a.2xlarge"
  client_name           = var.client_name
  parent_object         = var.parent_object
  tags                  = var.tags
  platform_endpoint     = var.platform_endpoint
  logstash_endpoint     = var.logstash_endpoint
  subnet_id             = var.subnet_id
  db_subnet_ids         = var.db_subnet_ids
  db_subnet_group       = var.db_subnet_group
  appagt_elastic_ip     = var.elastic_ip
}
