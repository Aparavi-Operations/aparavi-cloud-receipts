variable "aws_profile" {
  description = <<-EOT
    AWS profile name as set in the shared configuration and credentials files
    EOT
  type        = string
  default     = "prod"
}

variable "name" {
  description = "MANDATORY - Common resources name/prefix"
  type        = string
}

variable "key_name" {
  description = "MANDATORY - SSH Key name to attach to ec2 instances"
  type        = string
}

variable "db_password" {
  type = string
}

variable "client_name" {
  type = string
}

variable "parent_object" {
  type = string
}

variable "tags" {
  type = map(string)
}
