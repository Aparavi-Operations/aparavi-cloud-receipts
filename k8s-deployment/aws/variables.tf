variable "aws_profile" {
  description = <<EOT
    AWS profile name as set in the shared configuration and credentials files
    EOT
  type        = string
  default     = null
}

variable "name" {
  description = "Name of most resources"
  type        = string
  default     = "aparavi"
}

variable "vpc_cidr" {
  description = "The CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "vpc_private_subnets" {
  description = "A list of private subnets inside the VPC"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]

  validation {
    condition     = length(var.vpc_private_subnets) > 0
    error_message = "Specify at least one private subnet."
  }
}

variable "vpc_public_subnets" {
  description = "A list of public subnets inside the VPC"
  type        = list(string)
  default     = ["10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]

  validation {
    condition     = length(var.vpc_public_subnets) > 0
    error_message = "Specify at least one public subnet."
  }
}

variable "eks_cluster_endpoint_public_access" {
  description = <<EOT
     Indicates whether or not the Amazon EKS public API server endpoint is enabled
     EOT
  type        = bool
  default     = true
}

variable "eks_instance_types" {
  description = "Set of instance types associated with default Node Group."
  type        = list(string)
  default     = ["t3.2xlarge"]
}

variable "eks_max_size" {
  description = "EKS's 'default' node group max_size"
  type        = number
  default     = 2
}

variable "eks_min_size" {
  description = "EKS's 'default' node group min_size"
  type        = number
  default     = 2
}

variable "eks_desired_size" {
  description = "EKS's 'default' node group desired_size"
  type        = number
  default     = 2
}

variable "rds_apply_immediately" {
  description = <<EOT
    Specifies whether any database modifications are applied immediately, or
    during the next maintenance window
    EOT
  type        = bool
  default     = false
}

variable "rds_skip_final_snapshot" {
  description = <<EOT
    If true, no final snapshot is created. If false, a final snapshot is created
    before the DB instance is deleted
    EOT
  type        = bool
  default     = false
}

variable "rds_instance_class" {
  description = "The instance type of the RDS instance"
  type        = string
  default     = "db.t4g.micro"
}

variable "rds_allocated_storage" {
  description = "RDS allocated storage in gigabytes"
  type        = number
  default     = 100
}

variable "platform_host" {
  description = "Platform hostname[:port] to connect aggregator to"
  type        = string
  default     = null
}

variable "platform_node_id" {
  description = "Platform node ID to connect aggregator to"
  type        = string
  default     = null
}

variable "aggregator_node_name" {
  description = "Aggregator node name"
  type        = string
  default     = "aggregator"
}

variable "collector_node_name" {
  description = "Collector node name"
  type        = string
  default     = "collector"
}

variable "generate_sample_data" {
  description = "Generate sample data for collector"
  type        = bool
  default     = false
}
