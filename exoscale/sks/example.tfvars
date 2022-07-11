# Exoscale API key and secret
# https://community.exoscale.com/documentation/iam/quick-start/
api_key = "EXOxxxxxxxxxxxxxxxxxxxxxxxx"
api_secret = "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
# Exoscale zone you want to deploy resources in.
zone = "ch-dk-2"

# Main name of most of resources, such as SKS, DBaaS...
name = "aparavi"

# Aparavi platform host in HOSTNAME[:PORT] format
platform_host = "preview.aparavi.com"

# Aparavi platform node ID
platform_node_id = "11111111-aaaa-1111-aaaa-111111111111"
# Appagent node name. This will be the name shown in platform UI. If left
# empty, will default to "${var.name}-appagent", where ${var.name} is the
# value given above to variable 'name'.

appagent_node_name = ""
# Collector node name. This will be the name shown in platform UI. If left
# empty, will default to "${var.name}-collector", where ${var.name} is the
# value given above to variable 'name'.
collector_node_name = ""
# Set this to true to have some initial data in /opt/data on collector. This
# might be useful for quick demonstration.
generate_sample_data = true
# Samba service name to attach to appagent
data_samba_service = "//<server>/<service>"
# SMB username
data_samba_username = "samba"
# The password required to access the specified samba service
data_samba_password = "samba"
