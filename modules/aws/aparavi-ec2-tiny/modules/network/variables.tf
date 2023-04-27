variable "name" {
  type = string
}

variable "vpc_cidr" {
  type    = string
  default = "10.10.0.0/16"
}

variable "tags" {
  type = map(string)
}
