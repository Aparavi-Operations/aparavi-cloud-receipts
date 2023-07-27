vnet_cidr         = "10.240.8.0/21"
location          = "eastus2"
platfrom_size     = "Standard_E2bs_v5"
ssh_key           = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCbmsWBbZBLnGjsS4nJNoo0PxRj8Kk7VXZQ5IKvlSub90maZoGwS8/b4VWOgpZectaWeIdxAJyrcGISpDYJaGAS+b7T++LZfr2iz4g0b/PCuQTShiYOU6RMgVjpGmA2hszDFikRi0UOvrWg3b69n2Y2/W9+SVcbyprv+3a/RIxTVB8gB68F71hlRyls/N/u4V8Myg4zXiohJVwUoWxFaV+JcAOfCcFFqOfbMbPmHo/B88f/mVD6Ltgfo/9hqyLmYN4vbtHI98MZqMcTh7omwEDR2uEAfpwnyBuaP2LSDtnqCfy2MNSMuNSSlQNdFQD8mzY7pH7eTTNfT22sD+uzAmoOdyI8VE8iyzPjzEQpcoOHe1R3iR6YQGyHPYr3Ke1SvNiXwKV0DN0h5lLgc3GO2rUEm4jYDz7GqvIC2eE/aanYfZxRf7lqqsbd05icX4juuC5HcVxp3nBhgv1JzYwpp7aVg+T6IY7+ry3SAQYIimKNoyrjO1k2Ku+b8IRrIzuP1Kgz6addhIwRlWLc4B9MwySx0PECcPS1uyllrqyxtOqDmaLJ2BcJo91Pm965mbc24gByJ5XWzXUsN8cbRTHUDxG+pMZ1F3DMzagT2q6HwWebuTdrXJZsejxMiJFdRjR7jGsolI6UT22C6yFTSbHDq9NFcN/e6isB8NtvRyJ9sw4j8w=="
name              = "azure-demo-platform"
db_password       = "secr3tPassword"
db_shape          = "GP_Standard_D2ds_v4"
client_name       = "azure-demo"
logstash_endpoint = "logstash-ext.prod.aparavi.com"

resource_group_name  = "azure-demo"
virtual_network_name = "azure-demo"
subnet_name          = "azure-demo-public"
db_subnet_name       = "azure-demo-db"

tags = {
  owner = "DevOps"
  label = "test"
}
