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
platform_node_id = "11111111-aaaa-1111-aaaa-111111111111"
# Aggregator node name. This will be the name shown in platform UI. If left
# empty, will default to "${var.name}-aggregator", where ${var.name} is the
# value given above to variable 'name'.
appagent_node_name = "exoscale"

#vm_instance_type = "Tiny"