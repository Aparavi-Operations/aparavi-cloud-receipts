module "aparavi-vsphere" {
  source = "../../modules/vmware/aparavi-vsphere"

  datacenter       = var.datacenter
  datastore        = var.datastore
  cluster          = var.cluster
  network          = var.network
  template         = var.template
  platform_host    = var.platform_host
  platform_node_id = var.platform_node_id
  mysql            = var.mysql
  appagent         = var.appagent
  aggregator       = var.aggregator
  collector        = var.collector
}
