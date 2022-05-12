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
  description = "Region where resources reside"
  type        = string
  default     = "us-west1"
}
