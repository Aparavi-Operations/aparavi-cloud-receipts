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
  default     = "ch-dk-2"
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
