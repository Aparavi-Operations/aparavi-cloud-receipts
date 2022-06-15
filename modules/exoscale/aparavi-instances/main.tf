############################### Private Network ################################

locals {
  network = {
    cidr     = "192.168.100.0/24"
    start_ip = "192.168.100.10"
    end_ip   = "192.168.100.200"
    netmask  = "255.255.255.0"
  }
}

resource "exoscale_private_network" "network" {
  zone        = var.zone
  name        = var.name
  description = "Aparavi network"
  start_ip    = local.network.start_ip
  end_ip      = local.network.end_ip
  netmask     = local.network.netmask
}

data "exoscale_compute_template" "debian" {
    zone = var.zone
    name = "Linux Debian 11 (Bullseye) 64-bit"
}
################################################################################
resource "exoscale_ssh_key" "instance-key" {
  name       = "debian"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDFypoAJKpC/PhqV6LnYYaSjQ1Q9yFXLN3cqPfMqnvDY2E2sApIKgQse1P13Vrv8bKcNheR6f4wXtpG+lBvFGpUyH2/D8bhBH3H5ClehQDRALr9nwDPjGT32BZQ1md++ez6/F1qpFqDRGlJjPjMJTaXKtFlkahG2qYrrASRXbOFMHbqaUYTlMTEBz+YhqZV4EKMA24xw2qQh87Xr2N+FP6ysQ8BCpuPIWg6ha68oo694Pgfllr3RrICRvtlUdA9PpwOKPA7TSZXgsJqVU3WjY51CAkHiVkzORbIJnjDLVRzlvbMhUgeHvnZOGqKCWiMe7jtFU2p78c76A9tf4M/iZS+4h7NPOHdPstehgRWhQaBGKQDWyqryXoSlyNfYcgmdhwyWmdDhYAr45ZRXuYHxi70GPKzdkzS7yiwj3acwSQeqtgYvfoqa2U/4vn4d6jLJkc/VPyjQBhSEEac8OSKhlWcYl17WJm8mKaXrRk3a2SyIh/XDbOxPCWAeg8g4rUwDVs="
}
################################### Database ###################################

resource "random_password" "db_password" {
  length  = 32
  special = false # APARAVI Data IA Installer misbehaves on some of these.
}

locals {
  admin_username = "appagent"
}

resource "exoscale_database" "db" {
  zone                   = var.zone
  name                   = var.name
  type                   = "mysql"
  plan                   = var.dbaas_plan
  termination_protection = false

  mysql {
    version        = "8"
    admin_username = local.admin_username
    admin_password = random_password.db_password.result
    ip_filter = ["0.0.0.0/0"]
  }

  lifecycle {
    ignore_changes = [
      mysql
    ]
  }
}

################################################################################
resource "exoscale_ipaddress" "appagent-ingress" {
  zone = var.zone
  description = "Appagent elastic IP"
}

resource "exoscale_ipaddress" "monitoring-ingress" {
  zone = var.zone
  description = "Monitoring elastic IP"
}

resource "exoscale_ipaddress" "bastion-ingress" {
  zone = var.zone
  description = "Bastion elastic IP"
}

################################# VM Instances ##################################

resource "exoscale_security_group" "sg-appagent" {
    name = "sg-appagent"
}

resource "exoscale_security_group" "sg-monitoring" {
    name = "sg-monitoring"
}

resource "exoscale_security_group" "sg-bastion" {
    name = "sg-bastion"
}

resource "exoscale_security_group_rule" "bastion-ssh" {
    security_group_id = exoscale_security_group.sg-bastion.id
    type = "INGRESS"
    protocol = "tcp"
    cidr = "0.0.0.0/0"
    start_port = 22
    end_port = 22
}

resource "exoscale_security_group_rule" "appagent-ssh" {
    security_group_id = exoscale_security_group.sg-appagent.id
    type = "INGRESS"
    protocol = "tcp"
    cidr = "0.0.0.0/0"
    start_port = 22
    end_port = 22
}

resource "exoscale_security_group_rule" "appagent-exporter" {
    security_group_id = exoscale_security_group.sg-appagent.id
    type = "INGRESS"
    protocol = "tcp"
    cidr = "0.0.0.0/0"
    start_port = 9100
    end_port = 9100
}

resource "exoscale_security_group_rule" "monitoring-ssh" {
    security_group_id = exoscale_security_group.sg-monitoring.id
    type = "INGRESS"
    protocol = "tcp"
    cidr = "0.0.0.0/0"
    start_port = 22
    end_port = 22
}

resource "exoscale_security_group_rule" "monitoring-http" {
    security_group_id = exoscale_security_group.sg-monitoring.id
    type = "INGRESS"
    protocol = "tcp"
    cidr = "0.0.0.0/0"
    start_port = 80
    end_port = 80
}


data "template_file" "cloudinit-appagent" {
  template = file("../../modules/exoscale/aparavi-instances/init-appagent.tpl")

  vars = {
    ext_ip_address = exoscale_ipaddress.appagent-ingress.ip_address
    int_ip_address = "192.168.100.5"
  }
}

data "template_file" "cloudinit-monitoring" {
  template = file("../../modules/exoscale/aparavi-instances/init-monitoring.tpl")

  vars = {
    ext_ip_address = exoscale_ipaddress.appagent-ingress.ip_address
    int_ip_address = "192.168.100.6"
  }
}

data "template_file" "cloudinit-bastion" {
  template = file("../../modules/exoscale/aparavi-instances/init-bastion.tpl")

  vars = {
    ext_ip_address = exoscale_ipaddress.appagent-ingress.ip_address
    int_ip_address = "192.168.100.7"
  }
}

resource "exoscale_nic" "eth_intra_appagent" {
 # count = length(exoscale_compute.machine)

  compute_id = exoscale_compute.aparavi-appagent.id
  network_id = exoscale_private_network.network.id
}


resource "exoscale_nic" "eth_intra_bastion" {
 # count = length(exoscale_compute.machine)

  compute_id = exoscale_compute.aparavi-bastion.id
  network_id = exoscale_private_network.network.id
}

resource "exoscale_nic" "eth_intra_monitoring" {
 # count = length(exoscale_compute.machine)

  compute_id = exoscale_compute.aparavi-monitoring.id
  network_id = exoscale_private_network.network.id
}

resource "exoscale_compute" "aparavi-appagent" {
    display_name               = "aparavi-appagent"
    zone                = var.zone
    template_id = data.exoscale_compute_template.debian.id
    size = var.appagent_vm_instance_type
    disk_size = 50
    key_pair = exoscale_ssh_key.instance-key.id
    security_group_ids = [ exoscale_security_group.sg-appagent.id, ]
    user_data = data.template_file.cloudinit-appagent.rendered

    tags = {
        managedby = "terraform"
        app = "aparavi-agent"
    }
}


resource "exoscale_compute" "aparavi-monitoring" {
    display_name               = "aparavi-monitoring"
    zone                = var.zone
    template_id = data.exoscale_compute_template.debian.id
    size = var.monitoring_vm_instance_type
    disk_size = 50
    key_pair = exoscale_ssh_key.instance-key.id
    security_group_ids = [ exoscale_security_group.sg-monitoring.id, ]
    user_data = data.template_file.cloudinit-monitoring.rendered

    tags = {
        managedby = "terraform"
        app = "aparavi-monitoring"
    }
}

resource "exoscale_compute" "aparavi-bastion" {
    display_name               = "aparavi-bastion"
    zone                = var.zone
    template_id = data.exoscale_compute_template.debian.id
    size = var.bastion_vm_instance_type
    disk_size = 50
    key_pair = exoscale_ssh_key.instance-key.id
    security_group_ids = [ exoscale_security_group.sg-bastion.id, ]
    user_data = data.template_file.cloudinit-bastion.rendered

    tags = {
        managedby = "terraform"
        app = "aparavi-bastion"
    }
}


################################################################################
