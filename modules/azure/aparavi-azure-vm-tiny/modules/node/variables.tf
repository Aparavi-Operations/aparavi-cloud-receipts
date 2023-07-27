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

variable "db_subnet" {
  description = "Required ID of subnet to place DB"
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

variable "component" {
  type = string
}

# Userdata init variables
variable "init_repo" {
  type    = string
  default = "customer-scripts"
}

variable "init_repo_org" {
  type    = string
  default = "Aparavi-Operations"
}

variable "init_repo_branch" {
  type    = string
  default = "main"
}

variable "init_script" {
  type    = string
  default = "install_app.sh"
}

variable "init_options" {
  type    = string
  default = ""
}

variable "db_access_ips" {
  description = "Additional IP addresses to access DB from"
  default = []
}

variable "db_shape" {
  description = "Azure DB instance shape"
  type        = string
}

variable "db_size" {
  description = "Azure DB storage size"
  type        = string
}

variable "db_username" {
  description = "DB superadmin username"
  type        = string
  default     = "aparavi"
}

variable "db_password" {
  description = "DB superadmin password"
  type        = string
}

variable "client_name" {
  type = string
}

variable "parent_object" {
  type = string
}

variable "platform_endpoint" {
  type    = string
  default = "preview.aparavi.com"
}

variable "logstash_endpoint" {
  type    = string
  default = "logstash-hz.paas.aparavi.com"
}

variable "virtual_network_id" {
  type = string
}
