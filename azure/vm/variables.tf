variable "name" {
  description = "Common resources name"
  type = string
  default = "aparavienv"
}

variable "vnet_cidr" {
  description = "Virtual network common CIDR"
  type = string
  default = "10.0.0.0/8"
}

variable "location" {
  type = string
}

variable "platform" {
  type = string
  default = "preview.aparavi.com"
}

variable "parent_id" {
  type = string
}

variable "bastion_size" {
  type = string
  default = "Standard_DS1"
}

variable "db_shape" {
  type = string
  default = "GP_Gen5_4"
}

variable "collector_storage_size" {
  type = number
}

variable "db_user" {
  type = string
  default = "aparavi"
}

variable "db_password" {
  type = string
}

variable "aggregator_size" {
  type = string
  default = "Standard_E4bs_v5"
}

variable "collector_size" {
  type = string
  default = "Standard_E4bs_v5"
}

variable "monitoring_size" {
  type = string
  default = "Standard_DS1"
}

variable "monitoring_role_name" {
  type = string
  default = "Reader"
}

variable "ssh_key" {
  type = string
}

variable "tags" {
  description = "Tags associated with resources"
  type = map(string)
  default = {}
}
