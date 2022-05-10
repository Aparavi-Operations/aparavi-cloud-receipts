variable "name" {
  description = "Main name of resources"
  type        = string
  default     = "aparavi"
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
  description = "Aparavi platform host to connect aggregator to"
  type        = string
}

variable "platform_node_id" {
  description = "Aparavi platform node ID to connect aggregator to"
  type        = string
}

variable "aggregator_node_name" {
  description = "Aggregator node name"
  type        = string
  default     = "aggregator"
}

variable "collector_node_name" {
  description = "Collector node name"
  type        = string
  default     = "collector"
}

variable "generate_sample_data" {
  description = "Generate sample data for collector"
  type        = bool
  default     = false
}
