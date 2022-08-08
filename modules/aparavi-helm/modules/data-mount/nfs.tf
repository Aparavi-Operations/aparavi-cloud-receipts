locals {
  nfs_sources = { for k, v in var.sources : k => v if v.type == "nfs" }
}

resource "kubernetes_persistent_volume" "nfs" {
  for_each = local.nfs_sources

  metadata {
    name = each.key
  }
  spec {
    capacity = {
      storage = "1Mi" # irrelevant
    }
    access_modes                     = ["ReadWriteMany"]
    persistent_volume_reclaim_policy = "Retain"
    storage_class_name               = "nfs"
    persistent_volume_source {
      nfs {
        server    = each.value.server
        path      = each.value.path
        read_only = true
      }
    }
    mount_options = coalesce(each.value.mount_options, [])
  }
}

resource "kubernetes_persistent_volume_claim" "nfs" {
  for_each = local.nfs_sources

  metadata {
    name      = each.key
    namespace = var.namespace
  }
  spec {
    storage_class_name = kubernetes_persistent_volume.nfs[each.key].spec[0].storage_class_name
    access_modes       = kubernetes_persistent_volume.nfs[each.key].spec[0].access_modes
    resources {
      requests = {
        storage = kubernetes_persistent_volume.nfs[each.key].spec[0].capacity.storage
      }
    }
    volume_name = kubernetes_persistent_volume.nfs[each.key].metadata[0].name
  }
  wait_until_bound = true
}
