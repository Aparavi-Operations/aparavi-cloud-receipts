############################### Private Network ################################

locals {
  network = {
    cidr     = "192.168.0.0/24"
    start_ip = "192.168.0.1"
    end_ip   = "192.168.0.253"
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

################################################################################

################################### Database ###################################

resource "exoscale_database" "db" {
  zone                   = var.zone
  name                   = var.name
  type                   = "mysql"
  plan                   = var.dbaas_plan
  termination_protection = false

  mysql {
    version        = "8"
    admin_username = "aparavi"
    ip_filter      = ["0.0.0.0/0"] # Is there a better way?
  }

  lifecycle {
    ignore_changes = [
      mysql
    ]
  }
}

locals {
  db_creds = regex(
    "mysql://(?P<username>.*):(?P<password>.*)@(?P<hostname>.*):(?P<port>.*)/.*",
    exoscale_database.db.uri
  )
}

################################################################################

################################# SKS Cluster ##################################

module "sks" {
  source = "./modules/sks"

  zone                = var.zone
  name                = var.name
  cidr                = local.network.cidr
  instance_type       = var.sks_instance_type
  private_network_ids = [exoscale_private_network.network.id]
}

################################################################################

################################### Aparavi ####################################

provider "helm" {
  kubernetes {
    host                   = module.sks.host
    cluster_ca_certificate = module.sks.cluster_ca_certificate
    client_key             = module.sks.client_key
    client_certificate     = module.sks.client_certificate
  }
}

provider "kubernetes" {
  host                   = module.sks.host
  cluster_ca_certificate = module.sks.cluster_ca_certificate
  client_key             = module.sks.client_key
  client_certificate     = module.sks.client_certificate
}

module "aparavi" {
  source = "../../aparavi-helm"

  name             = "aparavi"
  chart_version    = "0.16.0"
  mysql_hostname   = local.db_creds["hostname"]
  mysql_port       = local.db_creds["port"]
  mysql_username   = local.db_creds["username"]
  mysql_password   = local.db_creds["password"]
  platform_host    = var.platform_host
  platform_node_id = var.platform_node_id
  appagent_node_name = coalesce(
    var.appagent_node_name,
    "${var.name}-appagent"
  )
  data_sources = var.data_sources

  depends_on = [
    exoscale_database.db,
    module.sks
  ]
}

################################################################################
