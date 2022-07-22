locals {
  azure_sources = { for k, v in var.sources : k => v if v.type == "azure" }
}

resource "kubernetes_persistent_volume" "azure" {
  for_each = local.azure_sources

  metadata {
    name = each.key
  }
  spec {
    capacity = {
      storage = "1Mi" # irrelevant
    }
    access_modes                     = ["ReadWriteOnce"]
    persistent_volume_reclaim_policy = "Retain"
    storage_class_name               = "azure"
    persistent_volume_source {
      csi {
        driver    = "disk.csi.azure.com"
        read_only = false
        volume_attributes = {
          fs_type = each.value.fs_type
        }
        volume_handle = each.value.volume_handle
      }
    }
  }
}

resource "kubernetes_persistent_volume_claim" "azure" {
  for_each = local.azure_sources

  metadata {
    name      = each.key
    namespace = var.namespace
  }
  spec {
    storage_class_name = kubernetes_persistent_volume.azure[each.key].spec[0].storage_class_name
    access_modes       = kubernetes_persistent_volume.azure[each.key].spec[0].access_modes
    resources {
      requests = {
        storage = kubernetes_persistent_volume.azure[each.key].spec[0].capacity.storage
      }
    }
    volume_name = kubernetes_persistent_volume.azure[each.key].metadata[0].name
  }
  wait_until_bound = true
}
