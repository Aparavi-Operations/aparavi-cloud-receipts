# Name of AWS CLI profile you want to use. This can be omitted if the [default]
# profile points to the account you want to deploy in.
aws_profile = "my-profile"
# AWS region to deploy resources in. If left blank or unspecified, CLI
# configuration value will be used.
region = "us-west-1"

# Main name of most of resources, such as VPC, EKS, RDS...
name = "aparavi"
# Tags to add to resources
tags = {
  service = "aparavi",
}

# Aparavi platform host in HOSTNAME[:PORT] format
platform_host = "preview.aparavi.com"
# Aparavi platform node ID
platform_node_id = "11111111-aaaa-1111-aaaa-111111111111"
# Appagent node name. This will be the name shown in platform UI. If left
# empty, will default to "${var.name}-appagent", where ${var.name} is the
# value given above to variable 'name'.
appagent_node_name = ""
