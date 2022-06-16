# Exoscale API key and secret
# https://community.exoscale.com/documentation/iam/quick-start/
api_key = "EXO...."
api_secret = "SOME_KEY"
# Exoscale zone you want to deploy resources in.
zone = "de-muc-1"

# Main name of most of resources, such as VNet, AKS, MySQL...
name = "aparavi"

# Aparavi platform host in HOSTNAME[:PORT] format
platform_host = "preview.aparavi.com"
# Aparavi platform node ID to connect aggregator to
platform_node_id = "111111-bbbb-bbbb-bbbb-11111111"
# Appagent node name. This will be the name shown in platform UI. If left
# empty, will default to "${var.name}-appagent", where ${var.name} is the
# value given above to variable 'name'.
appagent_node_name = "exoscale"
public_key = ""
#vm_instance_type = "Tiny"