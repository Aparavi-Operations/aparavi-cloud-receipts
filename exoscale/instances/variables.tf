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
  description = "Aparavi platform host to connect appagent to"
  type        = string
}

variable "platform_node_id" {
  description = "Aparavi platform node ID to connect appagent to"
  type        = string
}

variable "appagent_node_name" {
  description = "AppAgent node name. Default: \"$${var.name}-appagent\""
  type        = string
  default     = ""
}

variable "appagent_vm_instance_type" {
  description = "AppAgent instance type"
  type        = string
  default     = "Tiny"
}

variable "monitoring_vm_instance_type" {
  description = "monitoring instance type"
  type        = string
  default     = "Small"
}
variable "bastion_vm_instance_type" {
  description = "bastion instance type"
  type        = string
  default     = "Tiny"
}

variable "dbaas_plan" {
  description = "The plan of the database service"
  type        = string
  default     = "startup-8"
}

variable "public_key" {
  description = "SSH public key"
  type        = string
  default     = ""
}
variable "template_id" {
  description = "custom template id"
  type        = string
  default     = "0d3da3eb-3528-403c-bb18-58f33b14c069"
}