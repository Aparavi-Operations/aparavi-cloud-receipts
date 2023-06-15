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

variable "logstash_endpoint" {
  type    = string
  default = "logstash-hz.paas.aparavi.com"
}

variable "tags" {
  type = map(string)
}

variable "subnet_id" {
  description = "Existing subnet to create instance in"
  type        = string
  default     = ""
}

variable "db_subnet_ids" {
  description = "Existing subnet(s) to create db subnets in"
  type        = list(string)
  default     = []
}

variable "db_subnet_group" {
  description = "Existing db subnet group"
  type        = string
  default     = ""
}

variable "elastic_ip" {
  type    = string
  default = ""
}

variable "gh_token" {
  type = string
}