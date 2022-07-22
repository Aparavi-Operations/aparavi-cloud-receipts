locals {
  gce_sources = { for k, v in var.sources : k => v if v.type == "gce" }
}

resource "kubernetes_persistent_volume" "gce" {
  for_each = local.gce_sources

  metadata {
    name = each.key
  }
  spec {
    capacity = {
      storage = "1Mi" # irrelevant
    }
    access_modes                     = ["ReadWriteOnce"]
    persistent_volume_reclaim_policy = "Retain"
    storage_class_name               = "gce"
    persistent_volume_source {
      gce_persistent_disk {
        fs_type = each.value.fs_type
        pd_name = each.value.pd_name
      }
    }
  }
}

resource "kubernetes_persistent_volume_claim" "gce" {
  for_each = local.gce_sources

  metadata {
    name      = each.key
    namespace = var.namespace
  }
  spec {
    storage_class_name = kubernetes_persistent_volume.gce[each.key].spec[0].storage_class_name
    access_modes       = kubernetes_persistent_volume.gce[each.key].spec[0].access_modes
    resources {
      requests = {
        storage = kubernetes_persistent_volume.gce[each.key].spec[0].capacity.storage
      }
    }
    volume_name = kubernetes_persistent_volume.gce[each.key].metadata[0].name
  }
  wait_until_bound = true
}
