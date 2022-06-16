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
  description = "MySQL hostname"
  type        = string
}

variable "mysql_port" {
  description = "MySQL port"
  type        = number
  default     = 3306
}

variable "mysql_username" {
  description = "MySQL username"
  type        = string
}

variable "mysql_password" {
  description = "MySQL password"
  type        = string
}

variable "platform_host" {
  description = "Aparavi platform host[:port]"
  type        = string
}

variable "platform_node_id" {
  description = "Aparavi platform node ID"
  type        = string
}

variable "appagent_node_name" {
  description = "Appagent node name. Default: chart default"
  type        = string
  default     = ""
}

variable "appagent_node_selector" {
  description = "Appagent pod's nodeSelector"
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

variable "data_pvc_access_modes" {
  description = "PVC accessModes"
  type        = list(string)
  default     = ["ReadWriteOnce"]
}

variable "generate_sample_data" {
  description = "Generate sample data in appagent"
  type        = bool
  default     = false
}
