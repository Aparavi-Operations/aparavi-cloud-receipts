variable "zone" {
  description = "Exoscale zone name"
  type        = string
  default     = "de-muc-1"
}

variable "name" {
  description = "Main name of resources, such as SKS, DBAAS, etc"
  type        = string
  default     = "aparavi-exoscale"
}

#variable "vm_instance_type" {
#  description = "Type of Compute instances managed by the SKS default Nodepool"
#  type        = string
#  default     = "Tiny"
#}

variable "dbaas_plan" {
  description = "The plan of the database service"
  type        = string
  default     = "hobbyist-2"
}

variable "platform_host" {
  description = "Aparavi platform hostname[:port] to connect appagent to"
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
  default     = "Large"
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