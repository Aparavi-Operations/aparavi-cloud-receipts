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

variable "db_shape" {
  type    = string
  default = "GP_Gen5_4"
}

variable "db_size" {
  type    = string
  default = "20"
}

variable "db_username" {
  type    = string
  default = "aparavi"
}

variable "db_password" {
  type = string
}

variable "platfrom_node_size" {
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

variable "platfrom_disk_size" {
  type    = number
  default = 80
}

variable "platfrom_fw_ports" {
  description = "Map of TCP ports available internally"
  type        = any
  default = {
    "node_forwarder" = {
      "priority" = 210,
      "port"     = 9100,
      "source"   = ["3.223.232.7/32"]
    },
    "mysql_forwarder" = {
      "priority" = 220,
      "port"     = 9104,
      "source"   = ["3.223.232.7/32"]
    }
  }
}

variable "platfrom_init_repo" {
  type    = string
  default = "aparavi-ansible"
}

variable "platfrom_init_repo_org" {
  type    = string
  default = "Aparavi-Operations"
}

variable "platfrom_init_repo_branch" {
  type    = string
  default = "OPS-3946_install_platform_only"
}

variable "platfrom_init_script" {
  type    = string
  default = "install_app.sh"
}

variable "platform_init_options" {
  type    = string
  default = ""
}

variable "client_name" {
  type = string
}

variable "logstash_endpoint" {
  type    = string
  default = "logstash-hz.paas.aparavi.com"
}

variable "resource_group_name" {
  type    = string
  default = ""
}

variable "virtual_network_name" {
  type    = string
  default = ""
}

variable "subnet_name" {
  type    = string
  default = ""
}

variable "db_subnet_name" {
  type    = string
  default = ""
}

variable "gh_token" {
  type = string
}