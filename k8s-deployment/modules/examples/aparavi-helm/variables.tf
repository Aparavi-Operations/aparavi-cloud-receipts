variable "kubectl_config_context" {
  description = "kubectl config context"
  type        = string
  default     = null
}

variable "mysql_hostname" {
  description = "MySQL hostname for aggregator"
  type        = string
}

variable "mysql_password" {
  description = "MySQL password of 'aggregator' user"
  type        = string
}
