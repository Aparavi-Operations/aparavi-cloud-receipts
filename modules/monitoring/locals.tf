locals {
  ssh_port                 = 22
  grafana_port             = 80
  vminsert_http_port       = 8428
  vmagent_http_port        = 8429
  node_exporter_port       = 9100
  monitoring_ebs_size      = 8
  monitoring_instance_type = "t3.small"
}