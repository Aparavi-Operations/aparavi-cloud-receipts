module "aparavi-gce" {
  source = "../../modules/gcp/aparavi-gce"

  project                   = var.project
  region                    = var.region
  parentid                  = var.parentid
  bind_addr                 = var.bind_addr
  zone                      = var.zone
  vnet_name                 = var.vnet_name
  subnet-02_cidr            = var.subnet-02_cidr
  subnet_name               = var.subnet_name
  subnet_cidr               = var.subnet_cidr
  firewall_name             = var.firewall_name
  subnetwork_project        = var.subnetwork_project
  instances_name_collector  = var.instances_name_collector
  instances_name_aggregator = var.instances_name_aggregator
  instance_name_bastion     = var.instance_name_bastion
  instance_name_monitoring  = var.instance_name_monitoring
  admin                     = var.admin
  private_ip_aggregator     = var.private_ip_aggregator
  private_ip_collector      = var.private_ip_collector
  private_ip_monitoring     = var.private_ip_monitoring
  private_ip_bastion        = var.private_ip_bastion
  user_data_collector       = var.user_data_collector
  user_data_aggregator      = var.user_data_aggregator
  hostname_collector        = var.hostname_collector
  hostname_aggregator       = var.hostname_aggregator
  hostname_bastion          = var.hostname_bastion
  hostname_monitoring       = var.hostname_monitoring
  instance_name             = var.instance_name
  osdisk_size               = var.osdisk_size
  vm_type                   = var.vm_type
  vm_type_bastion           = var.vm_type_bastion
  vm_type_monitoring        = var.vm_type_monitoring
  name_prefix               = var.name_prefix
  master_user_name          = var.master_user_name
  master_user_password      = var.master_user_password
  mysql_version             = var.mysql_version
  machine_type              = var.machine_type
  db_name                   = var.db_name
  name_override             = var.name_override
}
