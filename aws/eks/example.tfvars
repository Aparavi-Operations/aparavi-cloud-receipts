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
# Aparavi platform node ID to connect aggregator to
platform_node_id = "11111111-aaaa-1111-aaaa-111111111111"
# Aggregator node name. This will be the name shown in platform UI. If left
# empty, will default to "${var.name}-aggregator", where ${var.name} is the
# value given above to variable 'name'.
aggregator_node_name = ""
# Collector node name. This will be the name shown in platform UI. If left
# empty, will default to "${var.name}-collector", where ${var.name} is the
# value given above to variable 'name'.
collector_node_name = ""
# Set this to true to have some initial data in /opt/data on collector. This
# might be useful for quick demonstration.
generate_sample_data = true
# EBS volume ID of the form aws://<az>/<ebs_volume_id> to attach to collector.
data_ebs_volume_id = "aws://<az>/vol-<ebs-volume-id>"
