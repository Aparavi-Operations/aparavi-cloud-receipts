# Exoscale API key and secret
# https://community.exoscale.com/documentation/iam/quick-start/
api_key = "EXOd146c7639b6f274b1498d083"
api_secret = "AKuS9mPrQb6ajCq3Q3NFogS3zvuww8-vDN_4CEDIrd0"
# Exoscale zone you want to deploy resources in.
zone = "de-muc-1"

# Main name of most of resources, such as VNet, AKS, MySQL...
name = "aparavi"

# Aparavi platform host in HOSTNAME[:PORT] format
platform_host = "preview.aparavi.com"
# Aparavi platform node ID to connect aggregator to
platform_node_id = "bbbbbbbb-bbbb-bbbb-bbbb-brdimitrenko"
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
