locals {
  ebs_sources = { for k, v in var.sources : k => v if v.type == "ebs" }
}

resource "kubernetes_persistent_volume" "ebs" {
  for_each = local.ebs_sources

  metadata {
    name = each.key
  }
  spec {
    capacity = {
      storage = "1Mi" # irrelevant
    }
    access_modes                     = ["ReadWriteOnce"]
    persistent_volume_reclaim_policy = "Retain"
    storage_class_name               = "ebs"
    persistent_volume_source {
      aws_elastic_block_store {
        fs_type   = each.value.fs_type
        volume_id = each.value.volume_id
      }
    }
  }
}

resource "kubernetes_persistent_volume_claim" "ebs" {
  for_each = local.ebs_sources

  metadata {
    name      = each.key
    namespace = var.namespace
  }
  spec {
    storage_class_name = kubernetes_persistent_volume.ebs[each.key].spec[0].storage_class_name
    access_modes       = kubernetes_persistent_volume.ebs[each.key].spec[0].access_modes
    resources {
      requests = {
        storage = kubernetes_persistent_volume.ebs[each.key].spec[0].capacity.storage
      }
    }
    volume_name = kubernetes_persistent_volume.ebs[each.key].metadata[0].name
  }
  wait_until_bound = true
}
