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
  admin_username = "aggregator"
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

resource "exoscale_sks_cluster" "sks" {
  zone         = var.zone
  name         = var.name
  auto_upgrade = true
}

resource "exoscale_security_group" "sks" {
  name = "sks"
}

resource "exoscale_security_group_rule" "sks" {

  for_each = {
    kubelet = {
      description = "SKS kubelet"
      protocol    = "TCP",
      port        = 10250,
      sg          = exoscale_security_group.sks.id
    }
    nodeports = {
      description = "NodePort services"
      protocol    = "TCP",
      port        = "30000-32767",
      cidr        = local.network.cidr
    }
    calico_vxlan_sg = {
      description = "Calico traffic"
      protocol    = "UDP",
      port        = 4789,
      sg          = exoscale_security_group.sks.id
    }
  }

  description       = each.value.description
  security_group_id = exoscale_security_group.sks.id
  protocol          = each.value.protocol
  type              = "INGRESS"
  start_port = try(
    split("-", each.value.port)[0],
    each.value.port,
    null
  )
  end_port = try(
    split("-", each.value.port)[1],
    each.value.port,
    null
  )
  user_security_group_id = try(each.value.sg, null)
  cidr                   = try(each.value.cidr, null)
}

resource "exoscale_sks_nodepool" "default" {
  zone                = var.zone
  cluster_id          = exoscale_sks_cluster.sks.id
  name                = "default"
  instance_type       = var.sks_instance_type
  size                = 2
  security_group_ids  = [exoscale_security_group.sks.id]
  private_network_ids = [exoscale_private_network.network.id]
}

################################################################################

################################### Aparavi ####################################

resource "exoscale_sks_kubeconfig" "kubeconfig" {
  zone                  = var.zone
  ttl_seconds           = 3600
  early_renewal_seconds = 300
  cluster_id            = exoscale_sks_cluster.sks.id
  user                  = "kubernetes-admin"
  groups                = ["system:masters"]
}

locals {
  kubeconfig = yamldecode(exoscale_sks_kubeconfig.kubeconfig.kubeconfig)
}

provider "helm" {
  kubernetes {
    host = local.kubeconfig.clusters[0].cluster.server
    cluster_ca_certificate = base64decode(
      local.kubeconfig.clusters[0].cluster.certificate-authority-data
    )
    client_key = base64decode(
      local.kubeconfig.users[0].user.client-key-data
    )
    client_certificate = base64decode(
      local.kubeconfig.users[0].user.client-certificate-data
    )
  }
}

provider "kubernetes" {
  host = local.kubeconfig.clusters[0].cluster.server
  cluster_ca_certificate = base64decode(
    local.kubeconfig.clusters[0].cluster.certificate-authority-data
  )
  client_key = base64decode(
    local.kubeconfig.users[0].user.client-key-data
  )
  client_certificate = base64decode(
    local.kubeconfig.users[0].user.client-certificate-data
  )
}

resource "helm_release" "longhorn" {
  count            = var.generate_sample_data ? 1 : 0
  name             = "longhorn"
  repository       = "https://charts.longhorn.io"
  chart            = "longhorn"
  version          = "1.2.4"
  namespace        = "longhorn-system"
  create_namespace = true

  depends_on = [exoscale_sks_nodepool.default]
}

locals {
  aggregator_node_name = coalesce(
    var.aggregator_node_name,
    "${var.name}-aggregator"
  )
  collector_node_name = coalesce(
    var.collector_node_name,
    "${var.name}-collector"
  )
}

module "aparavi" {
  source = "../../aparavi-helm"

  name                 = "aparavi"
  chart_version        = "0.15.0"
  mysql_hostname       = regex(".*@(.*):.*", exoscale_database.db.uri)[0]
  mysql_port           = 21699
  mysql_username       = local.admin_username
  mysql_password       = random_password.db_password.result
  platform_host        = var.platform_host
  platform_node_id     = var.platform_node_id
  aggregator_node_name = local.aggregator_node_name
  collector_node_name  = local.collector_node_name
  generate_sample_data = var.generate_sample_data

  depends_on = [
    exoscale_database.db,
    exoscale_sks_nodepool.default,
    helm_release.longhorn
  ]
}

################################################################################
