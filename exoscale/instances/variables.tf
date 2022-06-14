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

variable "platform_host" {
  description = "Aparavi platform host to connect aggregator to"
  type        = string
}

variable "platform_node_id" {
  description = "Aparavi platform node ID to connect aggregator to"
  type        = string
}

variable "appagent_node_name" {
  description = "AppAgent node name. Default: \"$${var.name}-appagent\""
  type        = string
  default     = ""
}
