variable "aws_profile" {
  description = <<EOT
    AWS profile name as set in the shared configuration and credentials files
    EOT
  type        = string
  default     = null
}

variable "region" {
  description = "AWS Region to deploy resources in"
  type        = string
  default     = "us-west-1"
}

variable "name" {
  description = "Name of most of resources"
  type        = string
  default     = "aparavi"
}

variable "tags" {
  description = "Map of tags to add to all resources"
  type        = map(string)
  default     = {}
}

variable "eks_instance_types" {
  description = "Set of instance types associated with default Node Group."
  type        = list(string)
  default     = ["t3.2xlarge"]
}

variable "rds_instance_class" {
  description = "The instance type of the RDS instance"
  type        = string
  default     = "db.m5.xlarge"
}

variable "rds_allocated_storage" {
  description = "RDS allocated storage in gigabytes"
  type        = number
  default     = 100
}

variable "rds_max_allocated_storage" {
  description = "The upper limit of RDS allocated storage in gigabytes"
  type        = number
  default     = 1000
}

variable "platform_host" {
  description = "Aparavi platform hostname[:port]"
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
