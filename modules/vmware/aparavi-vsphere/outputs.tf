output "mysql" {
  value = {
    os_user     = "aparavi"
    os_password = random_password.mysql["os"].result
    user        = "aparavi"
    password    = random_password.mysql["mysql"].result
    ip_address  = module.mysql.ip_address
  }
}

output "appagent" {
  value = {
    user       = "aparavi"
    password   = random_password.appagent.result
    ip_address = module.appagent.ip_address
  }
}

output "aggregator" {
  value = {
    user       = "aparavi"
    password   = random_password.aggregator.result
    ip_address = module.aggregator.ip_address
  }
}

output "collector" {
  value = {
    user       = "aparavi"
    password   = random_password.collector.result
    ip_address = module.collector.ip_address
  }
}
