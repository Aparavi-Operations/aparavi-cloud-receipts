output "rendered_config" {
  value = data.cloudinit_config.this.rendered
}