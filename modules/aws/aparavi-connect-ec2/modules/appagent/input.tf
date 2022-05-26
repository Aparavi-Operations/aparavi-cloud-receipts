variable "instance_count" {
  type    = number
  default = 1
}

variable "key_name" {
  type = string
}

variable "network_vpc_id" {
  type = string
}

variable "vm_subnet_id" {
  type = string
}

variable "rds_subnet_id_a" {
  type = string
}

variable "rds_subnet_id_b" {
  type = string
}

variable "management_network" {
  type = string
}

variable "platform" {
  type = string
}

variable "parent_id" {
  type = string
}

variable "deployment_tag" {
  type    = string
  default = "1"
}