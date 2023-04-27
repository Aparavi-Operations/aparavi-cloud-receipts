module "aparavi-ec2" {
  source = "../../modules/aws/aparavi-ec2-tiny"

  name                  = var.name
  key_name              = var.key_name
  appagt_mysql_password = var.db_password
  client_name           = var.client_name
  parent_object         = var.parent_object
  tags                  = var.tags
}
