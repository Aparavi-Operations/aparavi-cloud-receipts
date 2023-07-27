variable "name" {
  description = "MANDATORY - Common resources name/prefix"
  type        = string
}

variable "key_name" {
  description = "MANDATORY - SSH Key name to attach to ec2 instances"
  type        = string
}

variable "vpc_cidr" {
  type    = string
  default = "10.10.0.0/16"
}

variable "platform_instance_type" {
  type    = string
  default = "t3.medium"
}

variable "platform_root_size" {
  type    = number
  default = 80
}

variable "platform_db_size" {
  type    = number
  default = 100
}

variable "platform_mysql_version" {
  type    = string
  default = "8.0.32"
}

variable "platform_rds_multi_az" {
  type    = bool
  default = false
}

variable "platform_mysql_port" {
  type    = number
  default = 3306
}

variable "platform_mysql_username" {
  type    = string
  default = "aparavi"
}

variable "platform_mysql_password" {
  type = string
}

variable "platform_mysql_instance_type" {
  type    = string
  default = "db.t4g.large"
}

variable "platform_init_repo" {
  type    = string
  default = "aparavi-ansible"
}

variable "platform_init_repo_org" {
  type    = string
  default = "Aparavi-Operations"
}

variable "platform_init_repo_branch" {
  type    = string
  default = "OPS-3946_install_platform_only"
}

variable "platform_init_script" {
  type    = string
  default = "install_app.sh"
}

variable "platform_init_options" {
  type    = string
  default = ""
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

variable "platform_elastic_ip" {
  type    = string
  default = ""
}

variable "fqdn_address" {
  type    = string
  default = "test-platform.aparavi.com"
}

variable "gh_token" {
  type = string
}