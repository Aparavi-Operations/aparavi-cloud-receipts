variable "location" {
  description = "Azure location where resources reside"
  type        = string
  default     = "eastus"
}

variable "name" {
  description = <<-EOT
    Main name of resources, such as network, GKE cluster, Cloud SQl...
  EOT
  type        = string
  default     = "aparavi"
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
  default     = { service : "aparavi" }
}

variable "aks_agents_size" {
  description = "Virtual machine size for the Kubernetes agents"
  type        = string
  default     = "Standard_B4ms"
}

variable "mysql_sku_name" {
  description = <<-EOT
    The SKU Name for MySQL Server. The name of the SKU follows the
    tier + family + cores pattern (e.g. B_Gen4_1, GP_Gen5_8)
  EOT
  type        = string
  default     = "GP_Gen5_2"
}

variable "platform_host" {
  description = "Aparavi platform host"
  type        = string
}

variable "platform_node_id" {
  description = "Aparavi platform node ID"
  type        = string
}

variable "appagent_node_name" {
  description = "Appagent node name. Default: \"$${var.name}-appagent\""
  type        = string
  default     = ""
}

variable "data_sources" {
  description = "External data mount parameters"
  default     = {}
}
