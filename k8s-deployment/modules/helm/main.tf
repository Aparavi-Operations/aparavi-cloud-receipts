locals {
  namespace = "default"
}

resource "kubernetes_persistent_volume_claim" "data" {
  count = var.generate_sample_data ? 1 : 0
  metadata {
    name      = "${var.name}-data"
    namespace = local.namespace
    labels = {
      "app.kubernetes.io/name" : var.name
      "app.kubernetes.io/instance" : var.name
      "app.kubernetes.io/component" : "collector"
    }
  }
  spec {
    access_modes = ["ReadWriteOnce"]
    resources {
      requests = {
        storage = "2Gi"
      }
    }
  }
  wait_until_bound = false
}

resource "local_file" "values" {
  filename = "${path.cwd}/values.yaml"
  content = templatefile(
    "${path.module}/values.tftpl",
    {
      mysqlHostname      = var.mysql_hostname
      mysqlUsername      = var.mysql_username
      mysqlPassword      = var.mysql_password
      platformHost       = var.platform_host
      platformNodeId     = var.platform_node_id
      aggregatorNodeName = var.aggregator_node_name
      collectorNodeName  = var.collector_node_name
      generateSampleData = var.generate_sample_data
      claimName = (
        var.generate_sample_data ?
        kubernetes_persistent_volume_claim.data.0.metadata.0.name :
        ""
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
            claim_name = kubernetes_persistent_volume_claim.data.0.metadata.0.name
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

