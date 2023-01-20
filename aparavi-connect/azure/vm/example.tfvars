# Network CIDR for new VNET
vnet_cidr = "10.240.8.0/21"

# Common name prefix for resources
name = "azure"

# Azure location
location = "eastus2"

#Address of the platform to connect to.
platform = "preview.aparavi.com"

# Node id in platform hierarchy to attach resources to
parent_id = "bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb"

# Collector attached storage.
# Also used for appagent and DB storage calculation.
collector_storage_size = 100
workers_storage_size = 100

# VM shapes
# appagent_size = "Standard_E2bs_v5"

# SSH key for aparavi user on all VMs
ssh_key = "ssh-rsa XXXXX...."
