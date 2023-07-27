variable "name" {
  description = "Common resources name"
  type        = string
  default     = "aparavienv"
}

variable "vnet_cidr" {
  description = "Virtual network common CIDR"
  type        = string
  default     = "10.0.0.0/8"
}

variable "location" {
  type = string
}

variable "size" {
  type    = string
  default = "Standard_E4bs_v5"
}

variable "ssh_key" {
  type = string
}

variable "tags" {
  description = "Tags associated with resources"
  type        = map(string)
  default     = {}
}

variable "resource_group_name" {
  type = string
  default = ""
}

variable "virtual_network_name" {
  type = string
  default = ""
}

variable "subnet_name" {
  type = string
  default = ""
}

variable "disk_size" {
  type    = number
  default = 200
}

variable "fw_ports" {
  description = "Map of TCP ports available internally"
  type        = any
  default = {
    "node_forwarder" = {
      "priority" = 210,
      "port"     = 9100,
      "source"   = [ "3.223.232.7/32" ]
    },
    "mysql_forwarder" = {
      "priority" = 220,
      "port"     = 9104,
      "source"   = [ "3.223.232.7/32" ]
    }
  }
}
