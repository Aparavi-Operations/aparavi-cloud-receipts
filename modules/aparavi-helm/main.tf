locals {
  namespace = "default"
}

module "data-mount" {
  source = "./modules/data-mount"

  namespace = local.namespace
  sources   = var.data_sources
}

resource "local_file" "values" {
  filename = "${path.cwd}/values.yaml"
  content = templatefile(
    "${path.module}/values.yaml.tftpl",
    {
      mysqlHostname        = var.mysql_hostname
      mysqlPort            = var.mysql_port
      mysqlUsername        = var.mysql_username
      mysqlPassword        = var.mysql_password
      platformHost         = var.platform_host
      platformNodeId       = var.platform_node_id
      appagentNodeName     = var.appagent_node_name
      appagentNodeSelector = yamlencode(var.appagent_node_selector)
      claimNames           = module.data-mount.pvc_names
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
