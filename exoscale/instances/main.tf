data "exoscale_compute_template" "ubuntu" {
    zone = "de-fra-1"
    name = "Linux Ubuntu 20.04 LTS 64-bit"
}
data "template_file" "cloudinit-appagent" {
  template = file("init-appagent.tpl")

  vars = {
    eip = exoscale_ipaddress.appagent-ingress.ip_address
  }
}

data "template_file" "cloudinit-monitoring" {
  template = file("init-monitoring.tpl")

  vars = {
    eip = exoscale_ipaddress.monitoring-ingress.ip_address
  }
}

data "template_file" "cloudinit-bastion" {
  template = file("init-bastion.tpl")

  vars = {
    eip = exoscale_ipaddress.bastion-ingress.ip_address
  }
}


resource "exoscale_compute" "web-sv1" {
    display_name               = "web-sv1"
    zone = "de-fra-1"
    #display_name = "test"
    template_id = data.exoscale_compute_template.ubuntu.id
    #type               = "standard.medium"
    size = "Tiny"
    disk_size = 50
    #elastic_ip_ids = [exoscale_elastic_ip.aparavi-1.id]
    #public_ip_address = exoscale_elastic_ip.aparavi-1.id
    key_pair = exoscale_ssh_key.instance-key.id
    security_group_ids = [ exoscale_security_group.sg.id, ]
    user_data = data.template_file.cloudinit.rendered


    #network_interface {
    #    network_id = exoscale_private_network.aparavi-managed.id
    #    ip_address = "10.0.0.20"
    #}
    tags = {
        managedby = "terraform"
        app = "aparavi"
    }
}

output "username" {
  value = exoscale_compute.web-sv1.username
}

output "ip_address" {
  value = exoscale_compute.web-sv1.ip_address
}


###############################################################
module "aparavi-instances" {
  source = "../../modules/exoscale/aparavi-instances"

  zone                 = var.zone
  name                 = var.name
  vm_instance_type     = var.vm_instance_type
  dbaas_plan           = var.dbaas_plan
  platform_host        = var.platform_host
  platform_node_id     = var.platform_node_id
  appagent_node_name   = var.appagent_node_name
}
