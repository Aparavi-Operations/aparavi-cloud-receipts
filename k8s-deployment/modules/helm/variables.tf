variable "name" {
  description = "Helm release name"
  type        = string
  default     = "aparavi"
}

variable "chart_version" {
  description = "Aparavi Helm chart version. Default: latest"
  type        = string
  default     = ""
}

variable "mysql_hostname" {
  description = "MySQL hostname for aggregator"
  type        = string
}

variable "mysql_password" {
  description = "MySQL password of 'aggregator' user"
  type        = string
}

variable "platform_host" {
  description = "Aparavi platform host[:port] to connect aggregator to"
  type        = string
}

variable "platform_node_id" {
  description = "Aparavi platform node ID to connect aggregator to"
  type        = string
}

variable "aggregator_node_name" {
  description = "Aggregator node name. Default: chart default"
  type        = string
  default     = ""
}

variable "collector_node_name" {
  description = "Collector node name. Default: chart default"
  type        = string
  default     = ""
}

variable "generate_sample_data" {
  description = "Generate sample data in collector"
  type        = bool
  default     = false
}
