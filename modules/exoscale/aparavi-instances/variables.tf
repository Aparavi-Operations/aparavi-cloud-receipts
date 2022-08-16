variable "network" {
  description = "Exoscale private network"
  type        = map
  default = {
    cidr     = "192.168.100.0/24"
    start_ip = "192.168.100.10"
    end_ip   = "192.168.100.200"
    netmask  = "255.255.255.0"
  }
}

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
variable "public_key" {
  description = "SSH public key"
  type        = string
  default     = ""
}
variable "template_id" {
  description = "Exoscale custom template id"
  type        = string
  default     = "0d3da3eb-3528-403c-bb18-58f33b14c069"
}