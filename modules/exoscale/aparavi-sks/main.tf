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

resource "random_password" "db_password" {
  length  = 32
  special = false # APARAVI Data IA Installer misbehaves on some of these.
}

locals {
  admin_username = "aparavi"
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
    # TODO: try to use the new data source exoscale_instance_pool in version
    # 0.37.0 for a more specific ip filter matching only SKS nodes.
    ip_filter = ["0.0.0.0/0"]
  }

  lifecycle {
    ignore_changes = [
      mysql
    ]
  }
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

provider "kubernetes" {
  host                   = module.sks.host
  cluster_ca_certificate = module.sks.cluster_ca_certificate
  client_key             = module.sks.client_key
  client_certificate     = module.sks.client_certificate
}

resource "kubernetes_secret" "smbcreds" {
  count = var.data_samba_service != "" ? 1 : 0

  metadata {
    name      = "smbcreds"
    namespace = "default"
  }

  data = {
    username = var.data_samba_username
    password = var.data_samba_password
  }

  type = "Opaque"
}

resource "kubernetes_persistent_volume" "data" {
  count = var.data_samba_service != "" ? 1 : 0

  metadata {
    name = "aparavi-data"
  }
  spec {
    capacity = {
      storage = "2Gi" # irrelevant
    }
    access_modes                     = ["ReadWriteMany"]
    persistent_volume_reclaim_policy = "Retain"
    storage_class_name               = "aparavi"
    persistent_volume_source {
      csi {
        driver    = "smb.csi.k8s.io"
        read_only = false
        volume_attributes = {
          source = var.data_samba_service
        }
        volume_handle = "aparavi-data"
        node_stage_secret_ref {
          name      = kubernetes_secret.smbcreds[0].metadata[0].name
          namespace = kubernetes_secret.smbcreds[0].metadata[0].namespace
        }
      }
    }
    mount_options = [
      "cache=strict",
      "dir_mode=0777",
      "file_mode=0777",
      "mfsymlinks",
      "noperm",
      "noserverino",
      "uid=1000",
      "gid=1000"
    ]
  }
}

provider "helm" {
  kubernetes {
    host                   = module.sks.host
    cluster_ca_certificate = module.sks.cluster_ca_certificate
    client_key             = module.sks.client_key
    client_certificate     = module.sks.client_certificate
  }
}

module "aparavi" {
  source = "../../aparavi-helm"

  name             = "aparavi"
  chart_version    = "0.16.0"
  mysql_hostname   = regex(".*@(.*):.*", exoscale_database.db.uri)[0]
  mysql_port       = 21699
  mysql_username   = local.admin_username
  mysql_password   = random_password.db_password.result
  platform_host    = var.platform_host
  platform_node_id = var.platform_node_id
  appagent_node_name = coalesce(
    var.appagent_node_name,
    "${var.name}-appagent"
  )
  data_pv_name = try(
    kubernetes_persistent_volume.data[0].metadata[0].name,
    null
  )
  data_pvc_storage_class_name = try(
    kubernetes_persistent_volume.data[0].spec[0].storage_class_name,
    null
  )
  data_pvc_access_modes = try(
    kubernetes_persistent_volume.data[0].spec[0].access_modes,
    null
  )
  generate_sample_data = var.generate_sample_data

  depends_on = [
    exoscale_database.db,
    module.sks
  ]
}

################################################################################
