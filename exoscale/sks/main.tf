module "aparavi-sks" {
  source = "../../modules/exoscale/aparavi-sks"

  zone                 = var.zone
  name                 = var.name
  sks_instance_type    = var.sks_instance_type
  dbaas_plan           = var.dbaas_plan
  platform_host        = var.platform_host
  platform_node_id     = var.platform_node_id
  appagent_node_name   = var.appagent_node_name
  generate_sample_data = var.generate_sample_data
  data_samba_service   = var.data_samba_service
  data_samba_username  = var.data_samba_username
  data_samba_password  = var.data_samba_password
}
