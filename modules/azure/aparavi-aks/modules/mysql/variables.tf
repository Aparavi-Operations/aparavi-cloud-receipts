variable "resource_group_name" {
  description = "Azure Resource Group where resources are deployed"
  type        = string
}

variable "name" {
  description = <<-EOT
    Main name of resources, such as MySQL server and private endpoint
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

variable "sku_name" {
  description = <<-EOT
    The SKU Name for MySQL Server. The name of the SKU follows the
    tier + family + cores pattern (e.g. B_Gen4_1, GP_Gen5_8)
  EOT
  type        = string
  default     = "GP_Gen5_2"
}

variable "subnet_id" {
  description = <<-EOT
    The ID of the Subnet from which Private IP Addresses will be allocated for
    Private Endpoint
  EOT
  type        = string
}
