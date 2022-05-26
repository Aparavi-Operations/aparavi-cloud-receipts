locals {
  ssh_port           = 22
  node_exporter_port = 9100

  collector_http_port     = 9652
  collector_ebs_size      = 250
  collector_instance_type = "t3.medium"
}