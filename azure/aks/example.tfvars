# Azure location want to deploy resources in.
location="eastus"

# Main name of most of resources, such as VPC, EKS, RDS...
name = "aparavi"
# Labels to attach to resources
labels = {
  service: "aparavi",
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
