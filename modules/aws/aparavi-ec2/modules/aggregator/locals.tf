locals {
  ssh_port           = 22
  node_exporter_port = 9100

  mysql_port          = 3306
  mysql_username      = "aparavi"
  mysql_instance_type = "db.t4g.large"

  aggregator_http_port     = 9552
  aggregator_data_port     = 9545
  agent_data_port          = 9645
  aggregator_ebs_size      = 250
  aggregator_instance_type = "t3.medium"

  rds_creds = jsondecode(data.aws_secretsmanager_secret_version.rds_creds.secret_string)
}