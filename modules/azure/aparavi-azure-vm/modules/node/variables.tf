variable "name" {
  description = "Common resources name"
  type        = string
  default     = "aparavienv"
}

variable "resource_group_location" {
  description = "Required Resource group location"
  type        = string
}

variable "resource_group_name" {
  description = "Required Resource group name"
  type        = string
}

variable "vm_subnet" {
  description = "Required ID of subnet to place VM"
  type        = string
}

variable "custom_data" {
  description = "VM custom data"
  type        = string
  default     = null
}

variable "user_data" {
  description = "VM user data"
  type        = string
  default     = null
}

variable "vm_size" {
  description = "VM size type"
  type        = string
}

variable "disk_size" {
  description = "VM OS disk size"
  type        = number
  default     = 20
}

variable "fw_ports" {
  description = "Map of TCP ports available internally"
  type        = any
  default = {
    "data" = {
      "priority" = 200,
      "port"     = 9455,
    },
    "node_forwarder" = {
      "priority" = 210,
      "port"     = 9100,
    }
  }
}

variable "ssh_key" {
  type = string
}

variable "tags" {
  description = "Tags associated with resources"
  type        = map(string)
  default     = {}
}

variable "identity" {
  description = "Identity block content"
  type        = any
  default     = []
}