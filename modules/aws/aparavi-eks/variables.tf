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

variable "vpc_cidr" {
  description = "The CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "azs" {
  description = <<-EOT
    List of desired availability zones names or ids to deploy subnets in
  EOT
  type        = list(string)
  default     = []
}

variable "vpc_private_subnet_cidrs" {
  description = <<-EOT
    A list of private subnets inside the VPC. EKS nodes and RDS will be deployed
    in these subnets
  EOT
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]

  validation {
    condition     = length(var.vpc_private_subnet_cidrs) > 0
    error_message = "Specify at least one private subnet."
  }
}

variable "vpc_public_subnet_cidrs" {
  description = "A list of public subnets inside the VPC"
  type        = list(string)
  default     = ["10.0.3.0/24"]

  validation {
    condition     = length(var.vpc_public_subnet_cidrs) > 0
    error_message = "Specify at least one public subnet."
  }
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
