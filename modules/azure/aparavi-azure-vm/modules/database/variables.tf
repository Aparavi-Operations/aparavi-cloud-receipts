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

variable "db_access_ip" {
  description = "IP address to access DB from"
  type        = string
}

variable "db_shape" {
  description = "Azure DB instance shape"
  type        = string
}

variable "db_size" {
  description = "Azure DB storage size"
  type        = string
}

variable "db_user" {
  description = "DB superadmin username"
  type        = string
  default     = "aparavi"
}

variable "db_password" {
  description = "DB superadmin password"
  type        = string
}

variable "tags" {
  description = "Tags associated with resources"
  type        = map(string)
  default     = {}
}