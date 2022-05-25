variable "name" {
  description = "Name to be used on all the resources as identifier"
  type        = string
  default     = "aparavi"
}

variable "tags" {
  description = "Map of tags to add to all resources"
  type        = map(string)
  default     = {}
}

variable "cidr" {
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

variable "private_subnet_cidrs" {
  description = "List of private subnet CIDR's inside the VPC"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]

  validation {
    condition     = length(var.private_subnet_cidrs) >= 2
    error_message = "Specify at least two private subnets."
  }
}

variable "public_subnet_cidrs" {
  description = "List of public subnet CIDR's inside the VPC"
  type        = list(string)
  default     = ["10.0.3.0/24"]

  validation {
    condition     = length(var.public_subnet_cidrs) > 0
    error_message = "Specify at least one public subnet."
  }
}
