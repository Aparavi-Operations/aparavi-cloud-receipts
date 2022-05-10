module "aparavi" {
  source               = "../../aparavi-helm"
  name                 = "aparavi"
  mysql_hostname       = var.mysql_hostname
  mysql_password       = var.mysql_password
  platform_host        = "preview.aparavi.com"
  platform_node_id     = "bbbbbbbb-bbbb-bbbb-bbbb-brdimitrenko"
  aggregator_node_name = "helm-example-aggregator"
  collector_node_name  = "helm-example-collector"
  generate_sample_data = true
}
