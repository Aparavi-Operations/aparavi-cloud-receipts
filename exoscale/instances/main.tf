###############################################################
module "aparavi-instances" {
  source = "../../modules/exoscale/aparavi-instances"

  zone                 = var.zone
  name                 = var.name
  #vm_instance_type     = var.vm_instance_type
  bastion_vm_instance_type     = var.bastion_vm_instance_type
  monitoring_vm_instance_type     = var.monitoring_vm_instance_type
  dbaas_plan           = var.dbaas_plan
  platform_host        = var.platform_host
  platform_node_id     = var.platform_node_id
  appagent_node_name   = var.appagent_node_name
}
