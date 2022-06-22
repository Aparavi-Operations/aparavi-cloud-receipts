terraform {
  required_providers {
    exoscale = {
      source  = "exoscale/exoscale"
      version = ">= 0.37.1"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.5.1"
    }
  }
}

variable "zone" {}
variable "name" {}
variable "cidr" {}
variable "instance_type" {}
variable "private_network_ids" {}

output "cluster_id" { value = exoscale_sks_cluster.sks.id }
output "host" { value = local.host }
output "cluster_ca_certificate" { value = local.cluster_ca_certificate }
output "client_key" { value = local.client_key }
output "client_certificate" { value = local.client_certificate }

resource "exoscale_sks_cluster" "sks" {
  zone         = var.zone
  name         = var.name
  auto_upgrade = true
}

resource "exoscale_security_group" "sks" {
  name = "${var.name}-sks"
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
      cidr        = var.cidr
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
  instance_type       = var.instance_type
  size                = 1
  security_group_ids  = [exoscale_security_group.sks.id]
  private_network_ids = var.private_network_ids
}

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
  host       = local.kubeconfig.clusters[0].cluster.server
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

provider "helm" {
  kubernetes {
    host                   = local.host
    cluster_ca_certificate = local.cluster_ca_certificate
    client_key             = local.client_key
    client_certificate     = local.client_certificate
  }
}

resource "helm_release" "longhorn" {
  name             = "longhorn"
  repository       = "https://charts.longhorn.io"
  chart            = "longhorn"
  version          = "1.2.4"
  namespace        = "longhorn-system"
  create_namespace = true

  depends_on = [exoscale_sks_nodepool.default]
}

resource "helm_release" "csi-driver-smb" {
  name       = "csi-driver-smb"
  repository = "https://raw.githubusercontent.com/kubernetes-csi/csi-driver-smb/master/charts"
  chart      = "csi-driver-smb"
  version    = "1.7.0"
  namespace  = "kube-system"

  depends_on = [exoscale_sks_nodepool.default]
}
