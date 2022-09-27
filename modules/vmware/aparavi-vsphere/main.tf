data "vsphere_datacenter" "datacenter" {
  name = var.datacenter
}

data "vsphere_datastore" "datastore" {
  name          = var.datastore
  datacenter_id = data.vsphere_datacenter.datacenter.id
}

data "vsphere_compute_cluster" "cluster" {
  name          = var.cluster
  datacenter_id = data.vsphere_datacenter.datacenter.id
}

data "vsphere_network" "network" {
  name          = var.network
  datacenter_id = data.vsphere_datacenter.datacenter.id
}

data "vsphere_virtual_machine" "template" {
  name          = var.template
  datacenter_id = data.vsphere_datacenter.datacenter.id
}


resource "random_password" "mysql" {
  for_each = toset(["mysql", "os"])
  length   = 16
  special  = false
}

resource "local_file" "cloud-init-mysql" {
  filename = "${path.cwd}/cloud-init-mysql.yml"
  content = templatefile(
    "${path.module}/cloud-init-mysql.yml.tftpl",
    {
      hostname       = "aparavi-mysql"
      os_password    = random_password.mysql["os"].result
      mysql_password = random_password.mysql["mysql"].result
    }
  )
}

module "mysql" {
  source = "./modules/cloud-init-vm"

  enabled          = var.mysql["enabled"]
  name             = "aparavi-mysql"
  resource_pool_id = data.vsphere_compute_cluster.cluster.resource_pool_id
  datastore_id     = data.vsphere_datastore.datastore.id
  network_id       = data.vsphere_network.network.id
  template_uuid    = data.vsphere_virtual_machine.template.id
  user_data        = base64encode(local_file.cloud-init-mysql.content)
  num_cpus         = var.mysql["num_cpus"]
  memory           = var.mysql["memory"]
  disk_size        = var.mysql["disk_size"]
  guest_id         = var.mysql["guest_id"]
}

resource "random_password" "appagent" {
  length  = 16
  special = false
}

resource "local_file" "cloud-init-appagent" {
  filename = "${path.cwd}/cloud-init-appagent.yml"
  content = templatefile(
    "${path.module}/cloud-init-appagent.yml.tftpl",
    {
      hostname         = "aparavi-appagent"
      os_password      = random_password.appagent.result
      platform_host    = var.platform_host
      platform_node_id = var.platform_node_id
      mysql_host       = module.mysql.ip_address
      mysql_user       = "aparavi"
      mysql_password   = random_password.mysql["mysql"].result
    }
  )
}

module "appagent" {
  source = "./modules/cloud-init-vm"

  enabled          = var.appagent["enabled"]
  name             = "aparavi-appagent"
  resource_pool_id = data.vsphere_compute_cluster.cluster.resource_pool_id
  datastore_id     = data.vsphere_datastore.datastore.id
  network_id       = data.vsphere_network.network.id
  template_uuid    = data.vsphere_virtual_machine.template.id
  user_data        = base64encode(local_file.cloud-init-appagent.content)
  num_cpus         = var.appagent["num_cpus"]
  memory           = var.appagent["memory"]
  disk_size        = var.appagent["disk_size"]
  guest_id         = var.appagent["guest_id"]
}

resource "random_password" "aggregator" {
  length  = 16
  special = false
}

resource "local_file" "cloud-init-aggregator" {
  filename = "${path.cwd}/cloud-init-aggregator.yml"
  content = templatefile(
    "${path.module}/cloud-init-aggregator.yml.tftpl",
    {
      hostname         = "aparavi-aggregator"
      os_password      = random_password.aggregator.result
      platform_host    = var.platform_host
      platform_node_id = var.platform_node_id
      mysql_host       = module.mysql.ip_address
      mysql_user       = "aparavi"
      mysql_password   = random_password.mysql["mysql"].result
    }
  )
}

module "aggregator" {
  source = "./modules/cloud-init-vm"

  enabled          = var.aggregator["enabled"]
  name             = "aparavi-aggregator"
  resource_pool_id = data.vsphere_compute_cluster.cluster.resource_pool_id
  datastore_id     = data.vsphere_datastore.datastore.id
  network_id       = data.vsphere_network.network.id
  template_uuid    = data.vsphere_virtual_machine.template.id
  user_data        = base64encode(local_file.cloud-init-aggregator.content)
  num_cpus         = var.aggregator["num_cpus"]
  memory           = var.aggregator["memory"]
  disk_size        = var.aggregator["disk_size"]
  guest_id         = var.aggregator["guest_id"]
}

resource "random_password" "collector" {
  length  = 16
  special = false
}

resource "local_file" "cloud-init-collector" {
  filename = "${path.cwd}/cloud-init-collector.yml"
  content = templatefile(
    "${path.module}/cloud-init-collector.yml.tftpl",
    {
      hostname        = "aparavi-collector"
      os_password     = random_password.collector.result
      aggregator_host = module.aggregator.ip_address
    }
  )
}

module "collector" {
  source = "./modules/cloud-init-vm"

  enabled          = var.collector["enabled"]
  name             = "aparavi-collector"
  resource_pool_id = data.vsphere_compute_cluster.cluster.resource_pool_id
  datastore_id     = data.vsphere_datastore.datastore.id
  network_id       = data.vsphere_network.network.id
  template_uuid    = data.vsphere_virtual_machine.template.id
  user_data        = base64encode(local_file.cloud-init-collector.content)
  num_cpus         = var.collector["num_cpus"]
  memory           = var.collector["memory"]
  disk_size        = var.collector["disk_size"]
  guest_id         = var.collector["guest_id"]
}
