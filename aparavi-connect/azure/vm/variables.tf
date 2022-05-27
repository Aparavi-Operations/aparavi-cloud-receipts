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
  default = "westeurope"
}

variable "platform" {
  type    = string
  default = "preview.aparavi.com"
}

variable "parent_id" {
  type = string
  default = "bbbbbbbb-bbbb-bbbb-bbbb-brdimitrenko"
}

variable "bastion_size" {
  type    = string
  default = "Standard_D2s_v4"
}

variable "db_shape" {
  type    = string
  default = "GP_Gen5_4"
}

variable "collector_storage_size" {
  type = number
  default = 200
}

variable "db_user" {
  type    = string
  default = "aparavi"
}

variable "db_password" {
  type = string
  default = "supers3CretP@ssw0rd"
}

variable "node_size" {
  type    = string
  default = "Standard_D2s_v4"
}

variable "collector_size" {
  type    = string
  default = "Standard_D2s_v4"
}

variable "monitoring_size" {
  type    = string
  default = "Standard_D2s_v4"
}

variable "monitoring_role_name" {
  type    = string
  default = "Reader"
}

variable "ssh_key" {
  type = string
  default = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDqyefZ//CftxHIl+jMuwTSoYRmpEF73JkVXXNp4RKvgDJjgsv6a2mz//WgIUe9YSzw/9VgJPr5XxVJIZgOdEz8nscl2aT8wjy6cM/EGKQfytYSSOjf9xAE6+/OJ8cDum2NwXo9PQ4POHlOUC8ZZxVtKFzvhQHLdDUromaPLd8GyFeq5a23yiT30J/FoOsFtgPgJBMQL/0c9ZcsLjdc9yUw9qXPv76ztPNx70V1ecTQd144LP+0/IoT8LhCzNz1w2iN3BmIzc9v4ga6Jn01borN8FjCMEtiuuMYB19NYPboc+lg49BQaKSQfRM8hOGpUv6vAQPke8lr4xrmy3Fof67r user@Ilya"
}

variable "tags" {
  description = "Tags associated with resources"
  type        = map(string)
  default     = {}
}
