locals {
  smb_sources = { for k, v in var.sources : k => v if v.type == "smb" }
}

resource "helm_release" "csi-driver-smb" {
  count = length(local.smb_sources) > 0 ? 1 : 0

  name       = "csi-driver-smb"
  repository = "https://raw.githubusercontent.com/kubernetes-csi/csi-driver-smb/master/charts"
  chart      = "csi-driver-smb"
  version    = "1.8.0"
  namespace  = "kube-system"
}

resource "kubernetes_secret" "smb" {
  for_each = local.smb_sources

  metadata {
    name      = each.key
    namespace = var.namespace
  }

  data = {
    username = each.value.username
    password = each.value.password
  }

  type = "Opaque"
}

resource "kubernetes_persistent_volume" "smb" {
  for_each = local.smb_sources

  metadata {
    name = each.key
  }
  spec {
    capacity = {
      storage = "1Mi" # irrelevant
    }
    access_modes                     = ["ReadWriteMany"]
    persistent_volume_reclaim_policy = "Retain"
    storage_class_name               = "smb"
    persistent_volume_source {
      csi {
        driver    = "smb.csi.k8s.io"
        read_only = false
        volume_attributes = {
          source = each.value.source
        }
        volume_handle = each.key
        node_stage_secret_ref {
          name      = kubernetes_secret.smb[each.key].metadata[0].name
          namespace = kubernetes_secret.smb[each.key].metadata[0].namespace
        }
      }
    }
    mount_options = coalesce(each.value.mount_options, [])
  }
}

resource "kubernetes_persistent_volume_claim" "smb" {
  for_each = local.smb_sources

  metadata {
    name      = each.key
    namespace = var.namespace
  }
  spec {
    storage_class_name = kubernetes_persistent_volume.smb[each.key].spec[0].storage_class_name
    access_modes       = kubernetes_persistent_volume.smb[each.key].spec[0].access_modes
    resources {
      requests = {
        storage = kubernetes_persistent_volume.smb[each.key].spec[0].capacity.storage
      }
    }
    volume_name = kubernetes_persistent_volume.smb[each.key].metadata[0].name
  }
  wait_until_bound = true
}
