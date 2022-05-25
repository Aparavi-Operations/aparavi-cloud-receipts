variable "name" {
  description = "Main name of resources, such as VPC, Cloud NAT, etc."
  type        = string
}

variable "labels" {
  description = "Labels to apply to resources that support it"
  type        = map(string)
  default     = {}
}

variable "region" {
  description = "GCP region"
  type        = string
}

variable "zone" {
  description = "GCP zone to deploy GKE cluster in"
  type        = string
}

variable "network" {
  description = "ID of the network to connect db instance to"
  type        = string
}

variable "tier" {
  description = "The machine type to use"
  type        = string
}
