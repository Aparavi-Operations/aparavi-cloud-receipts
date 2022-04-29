# Service principal credentials and subscription information
client_id = ""
client_secret = ""
subscription_id = ""
tenant_id = ""

# Network CIDR for new VNET
vnet_cidr = "10.240.8.0/21"

# Common name prefix for resources
name = "azuretest"

# Azure location
location = "eastus2"

# Node id in platform hierarchy to attach resources to
parent_id = "bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb"

# Aggregator admin database password
db_password = "supers3CretP@ssw0rd"

# Collector attached storage.
# Also used for Aggregator and DB storage calculation.
collector_storage_size = 200

# VM shapes
aggregator_size = "Standard_E2bs_v5"
collector_size = "Standard_E2bs_v5"

# SSH key for aparavi user on all VMs
ssh_key = "ssh-rsa XXXXX...."
