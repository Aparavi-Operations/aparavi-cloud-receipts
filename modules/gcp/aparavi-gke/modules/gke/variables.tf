variable "name" {
  description = <<-EOT
    Main name of resources, such as subnet, GKE cluster...
  EOT
  type        = string
}

variable "labels" {
  description = "Labels to apply to resources that support it"
  type        = map(string)
  default     = {}
}

variable "region" {
  description = "GCP region where resources reside"
  type        = string
}

variable "zone" {
  description = "GCP zone to deploy GKE cluster in"
  type        = string
}

variable "machine_type" {
  description = "GCE machine type name to use in default node group"
  type        = string
}

variable "network" {
  description = "ID of the network to connect db instance to"
  type        = string
}
