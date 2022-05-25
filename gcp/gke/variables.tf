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
  description = "Aparavi platform host to connect aggregator to"
  type        = string
}

variable "platform_node_id" {
  description = "Aparavi platform node ID to connect aggregator to"
  type        = string
}

variable "aggregator_node_name" {
  description = "Aggregator node name. Default: \"$${var.name}-aggregator\""
  type        = string
  default     = ""
}

variable "collector_node_name" {
  description = "Collector node name. Default: \"$${var.name}-collector\""
  type        = string
  default     = ""
}

variable "generate_sample_data" {
  description = "Generate sample data for collector"
  type        = bool
  default     = false
}
