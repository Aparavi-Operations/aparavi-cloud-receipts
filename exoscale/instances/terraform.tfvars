# Exoscale API key and secret
# https://community.exoscale.com/documentation/iam/quick-start/
api_key = "EXO423423424"
api_secret = "......."
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

#set your public key here for ssh access
public_key = "ssh-rsa AAAAB3NzaC43543564564564567"

#set template id here, the default id "0d3da3eb-3528-403c-bb18-58f33b14c069" is Debian 11
#template_id = "0d3da3eb-3528-403c-bb18-58f33b14c069"

#set Appagent instance type here
appagent_vm_instance_type = "Large"