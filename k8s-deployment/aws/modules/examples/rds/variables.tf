variable "aws_profile" {
  description = <<EOT
    AWS profile name as set in the shared configuration and credentials files
    EOT
  type        = string
  default     = null
}

variable "aws_region" {
  description = "The AWS region where AWS provider will operate"
  type        = string
  default     = "us-east-1"
}

variable "subnet_ids" {
  description = "A list of VPC subnet IDs"
  type        = list(string)
  default     = []
}

variable "vpc_id" {
  description = "ID of the VPC where to create security group"
  type        = string
  default     = null
}

variable "sg_cidr_blocks" {
  description = "Inbound security group CIDR blocks"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
}
