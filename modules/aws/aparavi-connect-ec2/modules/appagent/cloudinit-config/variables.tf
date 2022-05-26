variable "cloudinit_config_gzip" {
  type    = bool
  default = false
}
variable "cloudinit_config_base64_encode" {
  type    = bool
  default = true
}
variable "parentid" {}
variable "platform_bind_addr" {}
variable "db_addr" {}
variable "db_user" {}
variable "db_passwd" {
  sensitive = true
}