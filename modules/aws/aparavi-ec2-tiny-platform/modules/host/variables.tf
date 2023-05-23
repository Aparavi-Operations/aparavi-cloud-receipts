# Common variables
variable "name" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "subnet_id" {
  type = string
}

variable "elastic_ip" {
  type    = string
  default = ""
}

variable "associate_public_ip" {
  type    = bool
  default = true
}

variable "instance_type" {
  type    = string
  default = "t3.medium"
}

variable "key_name" {
  type    = string
  default = null
}

variable "root_size" {
  type    = number
  default = 80
}

variable "tags" {
  type = map(string)
}

variable "component" {
  type = string
}

# Userdata init variables
variable "init_repo" {
  type    = string
  default = "customer-scripts"
}

variable "init_repo_org" {
  type    = string
  default = "Aparavi-Operations"
}

variable "init_repo_branch" {
  type    = string
  default = "main"
}

variable "init_script" {
  type    = string
  default = "install_app.sh"
}

variable "init_options" {
  type    = string
  default = ""
}

variable "gh_token" {
  type = string
}