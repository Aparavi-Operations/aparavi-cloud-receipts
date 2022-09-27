variable "datacenter" {
  type        = string
  description = "VSphere datacenter name to deploy resources into"
}

variable "datastore" {
  type        = string
  description = "VSphere datastore name to use for VM's"
}

variable "cluster" {
  type        = string
  description = "VSphere cluster name to deploy VM's into"
}

variable "network" {
  type        = string
  description = "VSphere network name to attach to VM's"
}

variable "template" {
  type        = string
  description = "VM template name to use for VM creation. Must have cloud-init."
}

variable "platform_host" {
  description = "Aparavi platform hostname[:port]"
  type        = string
}

variable "platform_node_id" {
  description = "Aparavi platform node ID"
  type        = string
}

variable "mysql" {
  description = "MySQL VM configuration"
  default = {
    enabled   = true
    num_cpus  = 4
    memory    = 16384
    disk_size = 200
    guest_id  = "ubuntu64Guest"
  }
}

variable "appagent" {
  description = "Appagent VM configuration"
  default = {
    enabled   = true
    num_cpus  = 4
    memory    = 16384
    disk_size = 200
    guest_id  = "ubuntu64Guest"
  }
}

variable "aggregator" {
  description = "Aggregator VM configuration"
  default = {
    enabled   = false
    num_cpus  = 4
    memory    = 16384
    disk_size = 200
    guest_id  = "ubuntu64Guest"
  }
}

variable "collector" {
  description = "Collector VM configuration"
  default = {
    enabled   = false
    num_cpus  = 4
    memory    = 16384
    disk_size = 200
    guest_id  = "ubuntu64Guest"
  }
}
