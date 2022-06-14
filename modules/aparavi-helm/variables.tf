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

variable "mysql_port" {
  description = "MySQL port"
  type        = number
  default     = 3306
}

variable "mysql_username" {
  description = "MySQL username for aggregator"
  type        = string
}

variable "mysql_password" {
  description = "MySQL password for aggregator"
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

variable "collector_node_selector" {
  description = "Collector pod's nodeSelector"
  type        = map(string)
  default     = {}
}

variable "data_pv_name" {
  description = "If not empty, a PVC will be created using this as volumeName"
  type        = string
  default     = null
}

variable "data_pvc_storage_class_name" {
  description = "PVC storageClassName"
  type        = string
  default     = null
}

variable "generate_sample_data" {
  description = "Generate sample data in collector"
  type        = bool
  default     = false
}
