# Network CIDR for new VNET
vnet_cidr = "10.240.8.0/21"

# Common name prefix for resources
name = "azuretest"

# Azure location
location = "eastus2"

#Address of the platform to connect to.
platform = "preview.aparavi.com"

# Node id in platform hierarchy to attach resources to
parent_id = "bbbbbbbb-bbbb-bbbb-bbbb-blpolezhaeva"

# Collector attached storage.
# Also used for appagent and DB storage calculation.
collector_storage_size = 100
workers_storage_size = 100

# VM shapes
# appagent_size = "Standard_E2bs_v5"

# SSH key for aparavi user on all VMs
ssh_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDqyefZ//CftxHIl+jMuwTSoYRmpEF73JkVXXNp4RKvgDJjgsv6a2mz//WgIUe9YSzw/9VgJPr5XxVJIZgOdEz8nscl2aT8wjy6cM/EGKQfytYSSOjf9xAE6+/OJ8cDum2NwXo9PQ4POHlOUC8ZZxVtKFzvhQHLdDUromaPLd8GyFeq5a23yiT30J/FoOsFtgPgJBMQL/0c9ZcsLjdc9yUw9qXPv76ztPNx70V1ecTQd144LP+0/IoT8LhCzNz1w2iN3BmIzc9v4ga6Jn01borN8FjCMEtiuuMYB19NYPboc+lg49BQaKSQfRM8hOGpUv6vAQPke8lr4xrmy3Fof67r user@Ilya"
