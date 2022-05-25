variable "name" {
  description = "The name of the RDS instance"
  type        = string
  default     = "aparavi"
}

variable "tags" {
  description = "A mapping of tags to assign to all resources"
  type        = map(string)
  default     = {}
}

variable "vpc_id" {
  description = "ID of the VPC where to create security group"
  type        = string
  default     = null
}

variable "subnet_ids" {
  description = "A list of VPC subnet IDs"
  type        = list(string)
  default     = null
}

variable "sg_cidr_blocks" {
  description = "Inbound security group CIDR blocks"
  type        = list(string)
  default     = []
}

variable "instance_class" {
  description = "The instance type of the RDS instance"
  type        = string
  default     = "db.t4g.micro"
}

variable "allocated_storage" {
  description = "The allocated storage in gigabytes"
  type        = number
  default     = 10
}

variable "max_allocated_storage" {
  description = "The upper limit of allocated storage in gigabytes"
  type        = number
  default     = 1000
}
