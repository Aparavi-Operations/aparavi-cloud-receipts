# Aparavi Helm Terraform Module

This module deploys Aparavi aggregator and collector with Helm.

## Usage

```hcl
provider "helm" {
  kubernetes {
    config_path = "~/.kube/config"
  }
}

module "aparavi" {
  source = "github.com/Aparavi-Operations/aparavi-cloud-receipts.git//modules/aparavi-helm"

  name                 = "aparavi"
  chart_version        = "0.15.0"
  mysql_hostname       = "mysql.example.com"
  mysql_port           = 3306
  mysql_username       = "aggregator"
  mysql_password       = "aggregator"
  platform_host        = "platform.example.com"
  platrofm_node_id     = "11111111-aaaa-1111-aaaa-111111111111"
  aggregator_node_name = "aggregator"
  collector_node_name  = "collector"
}
```

Then perform the following commands on the root folder:

- `terraform init` to get the plugins
- `terraform plan` to see the infrastructure plan
- `terraform apply` to apply the infrastructure build
- `terraform destroy` to destroy the built infrastructure

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aggregator_node_name"></a> [aggregator\_node\_name](#input\_aggregator\_node\_name) | Aggregator node name. Default: chart default | `string` | `""` | no |
| <a name="input_chart_version"></a> [chart\_version](#input\_chart\_version) | Aparavi Helm chart version. Default: latest | `string` | `""` | no |
| <a name="input_collector_node_name"></a> [collector\_node\_name](#input\_collector\_node\_name) | Collector node name. Default: chart default | `string` | `""` | no |
| <a name="input_generate_sample_data"></a> [generate\_sample\_data](#input\_generate\_sample\_data) | Generate sample data in collector | `bool` | `false` | no |
| <a name="input_mysql_hostname"></a> [mysql\_hostname](#input\_mysql\_hostname) | MySQL hostname for aggregator | `string` | n/a | yes |
| <a name="input_mysql_password"></a> [mysql\_password](#input\_mysql\_password) | MySQL password for aggregator | `string` | n/a | yes |
| <a name="input_mysql_port"></a> [mysql\_port](#input\_mysql\_port) | MySQL port | `number` | `3306` | no |
| <a name="input_mysql_username"></a> [mysql\_username](#input\_mysql\_username) | MySQL username for aggregator | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | Helm release name | `string` | `"aparavi"` | no |
| <a name="input_platform_host"></a> [platform\_host](#input\_platform\_host) | Aparavi platform host[:port] to connect aggregator to | `string` | n/a | yes |
| <a name="input_platform_node_id"></a> [platform\_node\_id](#input\_platform\_node\_id) | Aparavi platform node ID to connect aggregator to | `string` | n/a | yes |
