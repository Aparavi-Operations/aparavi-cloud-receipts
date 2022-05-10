variable "name" {
  description = "The name of the RDS instance"
  type        = string
  default     = "aparavi"
}

variable "apply_immediately" {
  description = <<EOT
    Specifies whether any database modifications are applied immediately, or
    during the next maintenance window
    EOT
  type        = bool
  default     = false
}

variable "instance_class" {
  description = "The instance type of the RDS instance"
  type        = string
  default     = "db.t4g.micro"
}

variable "allocated_storage" {
  description = "The allocated storage in gigabytes"
  type        = number
  default     = 100
}

variable "username" {
  description = "Username for the master DB user"
  type        = string
  default     = "aparavi"
}

variable "db_name" {
  description = "The DB name to create."
  type        = string
  default     = "aparavi"
}

variable "subnet_ids" {
  description = "A list of VPC subnet IDs"
  type        = list(string)
  default     = null
}

variable "skip_final_snapshot" {
  description = <<EOT
    If true, no final snapshot is created. If false, a final snapshot is created
    before the DB instance is deleted
    EOT
  type        = bool
  default     = false
}

variable "vpc_id" {
  description = "ID of the VPC where to create security group"
  type        = string
  default     = null
}

variable "sg_cidr_blocks" {
  description = "Inbound security group CIDR blocks"
  type        = list(string)
  default     = []
}

variable "tags" {
  description = "A mapping of tags to assign to all resources"
  type        = map(string)
  default     = {}
}
