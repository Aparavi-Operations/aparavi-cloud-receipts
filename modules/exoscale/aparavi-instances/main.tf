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

data "exoscale_compute_template" "ubuntu" {
    zone = var.zone
    name = "Linux Ubuntu 20.04 LTS 64-bit"
}
################################################################################

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
    security_group_id = exoscale_security_group.sg-monitoring.id
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

data "exoscale_compute_template" "ubuntu" {
    zone = var.zone
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


resource "exoscale_compute" "aparavi-appagent" {
    display_name               = "aparavi-appagent"
    zone                = var.zone
    #display_name = "test"
    template_id = data.exoscale_compute_template.ubuntu.id
    #type               = "standard.medium"
    size = var.vm_instance_type
    disk_size = 50
    #elastic_ip_ids = [exoscale_elastic_ip.aparavi-1.id]
    #public_ip_address = exoscale_elastic_ip.aparavi-1.id
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
    #display_name = "test"
    template_id = data.exoscale_compute_template.ubuntu.id
    #type               = "standard.medium"
    size = var.monitoring_vm_instance_type
    disk_size = 50
    #elastic_ip_ids = [exoscale_elastic_ip.aparavi-1.id]
    #public_ip_address = exoscale_elastic_ip.aparavi-1.id
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
    #display_name = "test"
    template_id = data.exoscale_compute_template.ubuntu.id
    #type               = "standard.medium"
    size = var.bastion_vm_instance_type
    disk_size = 50
    #elastic_ip_ids = [exoscale_elastic_ip.aparavi-1.id]
    #public_ip_address = exoscale_elastic_ip.aparavi-1.id
    key_pair = exoscale_ssh_key.instance-key.id
    security_group_ids = [ exoscale_security_group.sg-bastion.id, ]
    user_data = data.template_file.cloudinit-bastion.rendered

    tags = {
        managedby = "terraform"
        app = "aparavi-bastion"
    }
}


################################################################################
