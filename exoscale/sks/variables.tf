variable "api_key" {
  description = "Exoscale API key"
  type        = string
}

variable "api_secret" {
  description = "Exoscale API secret"
  type        = string
}

variable "zone" {
  description = "Exoscale zone name"
  type        = string
  default     = "de-muc-1"
}

variable "name" {
  description = "Main name of resources, such as SKS, DBAAS, etc"
  type        = string
  default     = "aparavi"
}

variable "sks_instance_type" {
  description = "Type of Compute instances managed by the SKS default Nodepool"
  type        = string
  default     = "standard.extra-large"
}

variable "dbaas_plan" {
  description = "The plan of the database service"
  type        = string
  default     = "hobbyist-2"
}

variable "platform_host" {
  description = "Aparavi platform host to connect aggregator to"
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
  description = "Generate sample data for collector"
  type        = bool
  default     = false
}
