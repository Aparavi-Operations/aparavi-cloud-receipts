variable "cloudinit_config_gzip" {
  type    = bool
  default = false
}
variable "cloudinit_config_base64_encode" {
  type    = bool
  default = true
}
variable "deployment_name" {}
variable "appagent_private_ip" {}
variable "monitoring_private_ip" {
  type    = string
  default = "127.0.0.1"
}