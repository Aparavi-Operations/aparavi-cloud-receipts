locals {
  namespace = "default"
}

resource "kubernetes_persistent_volume_claim" "data" {
  count = var.data_pv_name != null || var.generate_sample_data ? 1 : 0

  metadata {
    name      = "${var.name}-data"
    namespace = local.namespace
  }
  spec {
    storage_class_name = var.data_pvc_storage_class_name
    access_modes       = ["ReadWriteOnce"]
    resources {
      requests = {
        storage = "2Gi"
      }
    }
    volume_name = var.data_pv_name
  }
  wait_until_bound = var.data_pv_name != null ? true : false
}

resource "local_file" "values" {
  filename = "${path.cwd}/values.yaml"
  content = templatefile(
    "${path.module}/values.yaml.tftpl",
    {
      mysqlHostname         = var.mysql_hostname
      mysqlPort             = var.mysql_port
      mysqlUsername         = var.mysql_username
      mysqlPassword         = var.mysql_password
      platformHost          = var.platform_host
      platformNodeId        = var.platform_node_id
      aggregatorNodeName    = var.aggregator_node_name
      collectorNodeName     = var.collector_node_name
      collectorNodeSelector = yamlencode(var.collector_node_selector)
      claimName = try(
        kubernetes_persistent_volume_claim.data[0].metadata[0].name,
        null
      )
    }
  )
  file_permission = "0664"
}

resource "helm_release" "aparavi" {
  name             = var.name
  repository       = "https://aparavi-operations.github.io/helm-charts"
  chart            = "aparavi"
  version          = var.chart_version
  namespace        = local.namespace
  create_namespace = true
  values           = [local_file.values.content]
}

resource "kubernetes_job" "data" {
  count = var.generate_sample_data ? 1 : 0

  metadata {
    name      = "${var.name}-populate-data"
    namespace = local.namespace
    labels = {
      "app.kubernetes.io/name" : var.name
      "app.kubernetes.io/instance" : var.name
      "app.kubernetes.io/component" : "collector"
    }
  }
  spec {
    template {
      metadata {}
      spec {
        affinity {
          pod_affinity {
            required_during_scheduling_ignored_during_execution {
              label_selector {
                match_expressions {
                  key      = "app.kubernetes.io/component"
                  operator = "In"
                  values   = ["collector"]
                }
              }
              topology_key = "kubernetes.io/hostname"
            }
          }
        }
        container {
          name    = "populate-data"
          image   = "busybox"
          command = ["/bin/sh", "-c"]
          args = [
            <<-EOT
            cd /opt/data && \
            wget \
              -O samplelib.zip \
              https://github.com/ffeast/samplelib/archive/refs/heads/master.zip  && \
            unzip -o samplelib.zip
            EOT
          ]
          volume_mount {
            name       = "data"
            mount_path = "/opt/data"
          }
        }
        volume {
          name = "data"
          persistent_volume_claim {
            claim_name = kubernetes_persistent_volume_claim.data[0].metadata[0].name
          }
        }
        restart_policy = "Never"
      }
    }
    backoff_limit = 4
  }
  wait_for_completion = true
  depends_on          = [helm_release.aparavi]
}
