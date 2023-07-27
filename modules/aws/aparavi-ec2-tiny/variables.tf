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

variable "appagt_instance_type" {
  type    = string
  default = "t3.medium"
}

variable "appagt_root_size" {
  type    = number
  default = 80
}

variable "appagt_db_size" {
  type    = number
  default = 100
}

variable "appagt_mysql_version" {
  type    = string
  default = "8.0.32"
}

variable "appagt_rds_multi_az" {
  type    = bool
  default = false
}

variable "appagt_mysql_port" {
  type    = number
  default = 3306
}

variable "appagt_mysql_username" {
  type    = string
  default = "aparavi"
}

variable "appagt_mysql_password" {
  type = string
}

variable "appagt_mysql_instance_type" {
  type    = string
  default = "db.t4g.large"
}

variable "appagt_init_repo" {
  type    = string
  default = "customer-scripts"
}

variable "appagt_init_repo_org" {
  type    = string
  default = "Aparavi-Operations"
}

variable "appagt_init_repo_branch" {
  type    = string
  default = "main"
}

variable "appagt_init_script" {
  type    = string
  default = "install_app.sh"
}

variable "appagt_init_options" {
  type    = string
  default = ""
}

variable "client_name" {
  type = string
}

variable "parent_object" {
  type = string
}

variable "platform_endpoint" {
  type    = string
  default = "preview.aparavi.com"
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

variable "appagt_elastic_ip" {
  type    = string
  default = ""
}
