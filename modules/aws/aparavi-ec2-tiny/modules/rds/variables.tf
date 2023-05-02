# Common variables
variable "name" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "tags" {
  type = map(string)
}

variable "component" {
  type = string
}

# Database variables
variable "subnet_group" {
  type = string
}

variable "size" {
  type    = number
  default = 100
}

variable "mysql_version" {
  type    = string
  default = "8.0.32"
}

variable "multi_az" {
  type    = bool
  default = false
}

variable "mysql_port" {
  type    = number
  default = 3306
}

variable "mysql_username" {
  type    = string
  default = "aparavi"
}

variable "mysql_password" {
  type = string
}

variable "mysql_instance_type" {
  type    = string
  default = "db.t4g.large"
}
