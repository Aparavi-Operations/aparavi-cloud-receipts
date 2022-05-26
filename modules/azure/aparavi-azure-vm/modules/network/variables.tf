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

variable "vnet_cidr" {
  description = "Virtual network common CIDR"
  type        = string
  default     = "10.0.0.0/8"
}

variable "tags" {
  description = "Tags associated with resources"
  type        = map(string)
  default     = {}
}