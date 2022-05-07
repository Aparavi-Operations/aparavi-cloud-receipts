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

variable "vpc_id" {
  description = "VPC ID to deploy the cluster in"
  type        = string
  default     = null
}

variable "subnet_ids" {
  description = "List of subnet ID's in VPC"
  type        = list(string)
  default     = null
}
