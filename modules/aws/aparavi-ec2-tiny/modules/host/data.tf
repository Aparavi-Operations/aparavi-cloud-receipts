data "aws_ami" "host_ami" {
  most_recent = true

  filter {
    name   = "name"
    values = ["debian-11-amd64-*"]
  }

  owners = ["136693071363"]
}
