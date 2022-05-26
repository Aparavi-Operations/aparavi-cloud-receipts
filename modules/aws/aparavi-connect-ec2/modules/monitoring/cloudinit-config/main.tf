data "cloudinit_config" "this" {
  gzip          = var.cloudinit_config_gzip
  base64_encode = var.cloudinit_config_base64_encode
  part {
    content_type = "text/x-shellscript"
    filename     = "user-data.sh"
    content = templatefile("${path.module}/user-data.sh.tpl", {
      deployment_name       = var.deployment_name
      appagent_private_ip   = var.appagent_private_ip
      monitoring_private_ip = var.monitoring_private_ip
    })
  }
}