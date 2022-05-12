variable "name" {
  description = "Main name of resources, such as VPC, Cloud NAT, etc."
  type        = string
  default     = "aparavi"
}

variable "labels" {
  description = "Labels to apply to resources that support it"
  type        = map(string)
  default     = { service : "aparavi" }
}

variable "region" {
  description = "GCP region"
  type        = string
  default     = "us-west1"
}

variable "zone" {
  description = "GCP zone to deploy GKE cluster in"
  type        = string
  default     = "us-west1-a"
}

variable "network" {
  description = "ID of the network to connect db instance to"
  type        = string
}

variable "tier" {
  description = "The machine type to use"
  type        = string
  default     = "db-f1-micro"
}
