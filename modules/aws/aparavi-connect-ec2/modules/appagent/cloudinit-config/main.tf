data "cloudinit_config" "this" {
  gzip          = var.cloudinit_config_gzip
  base64_encode = var.cloudinit_config_base64_encode
  part {
    content_type = "text/x-shellscript"
    filename     = "user-data.sh"
    content = templatefile("${path.module}/user-data.sh.tpl", {
      platform_bind_addr = var.platform_bind_addr
      db_addr            = var.db_addr
      db_user            = var.db_user
      db_passwd          = var.db_passwd
      parentId           = var.parentid
    })
  }
}