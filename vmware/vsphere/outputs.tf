output "mysql" {
  value     = module.aparavi-vsphere.mysql
  sensitive = true
}

output "appagent" {
  value     = module.aparavi-vsphere.appagent
  sensitive = true
}

output "aggregator" {
  value     = module.aparavi-vsphere.aggregator
  sensitive = true
}

output "collector" {
  value     = module.aparavi-vsphere.collector
  sensitive = true
}
