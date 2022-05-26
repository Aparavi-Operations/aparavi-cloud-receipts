variable "name" {
  description = <<-EOT
    Main name of resources, such as Resource Groups, AKS Cluster,
    SQL Database...
  EOT
  type        = string
  default     = "aparavi"
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
  default     = { service : "aparavi" }
}

variable "location" {
  description = "Azure location where resources reside"
  type        = string
  default     = "eastus"
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

variable "aparavi_chart_version" {
  description = "Aparavi Helm chart version. Default: latest"
  type        = string
  default     = ""
}

variable "platform_host" {
  description = "Aparavi platform hostname[:port] to connect aggregator to"
  type        = string
}

variable "platform_node_id" {
  description = "Aparavi platform node ID to connect aggregator to"
  type        = string
}

variable "aggregator_node_name" {
  description = "Aggregator node name. Default: \"$${var.name}-aggregator\""
  type        = string
  default     = ""
}

variable "collector_node_name" {
  description = "Collector node name. Default: \"$${var.name}-collector\""
  type        = string
  default     = ""
}

variable "generate_sample_data" {
  description = "Generate sample data in collector"
  type        = bool
  default     = false
}
