variable "project" {
  description = "GCP Project ID"
  type        = string
}

variable "region" {
  description = "Region where resources reside"
  type        = string
  default     = "us-west1"
}

variable "zone" {
  description = "GCP zone to deploy GKE cluster in"
  type        = string
  default     = "us-west1-a"
}

variable "name" {
  description = <<-EOT
    Main name of resources, such as network, GKE cluster, Cloud SQl...
  EOT
  type        = string
  default     = "aparavi"
}

variable "labels" {
  description = "Labels to apply to resources that support it"
  type        = map(string)
  default     = { service : "aparavi" }
}

variable "gke_machine_type" {
  description = "GCE machine type name to use in default node group"
  type        = string
  default     = "custom-8-16384"
}

variable "cloudsql_tier" {
  description = "The machine type to use in Cloud SQL instance"
  type        = string
  default     = "db-f1-micro"
}

variable "platform_host" {
  description = "Aparavi platform host"
  type        = string
}

variable "platform_node_id" {
  description = "Aparavi platform node ID"
  type        = string
}

variable "appagent_node_name" {
  description = "Appagent node name. Default: \"$${var.name}-appagent\""
  type        = string
  default     = ""
}

variable "data_sources" {
  description = "External data mount parameters"
  default     = {}
}
