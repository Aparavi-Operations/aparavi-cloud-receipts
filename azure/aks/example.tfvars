# Azure location want to deploy resources in.
location = "eastus"

# Main name of most of resources, such as VNet, AKS, MySQL...
name = "aparavi"
# Tags to attach to resources
tags = {
  service : "aparavi",
}

# Aparavi platform host in HOSTNAME[:PORT] format
platform_host = "preview.aparavi.com"
# Aparavi platform node ID
platform_node_id = "11111111-aaaa-1111-aaaa-111111111111"
# appagent node name. This will be the name shown in platform UI. If left
# empty, will default to "${var.name}-appagent", where ${var.name} is the
# value given above to variable 'name'.
appagent_node_name = ""
# Set this to true to have some initial data in /opt/data on collector. This
# might be useful for quick demonstration.
generate_sample_data = true
