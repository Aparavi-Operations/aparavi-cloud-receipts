# Aparavi on Azure Kubernetes Service (AKS) Terraform Module

This module deploys Aparavi aggregator and collector on Azure Kubernetes
Service (AKS). Resources this module will create are:

- Virtual Network.
- AKS cluster
- Azure Database for MySQL
- Aparavi Helm release

## Usage

An example usage of this module is also in [../../../azure/aks/](../../../azure/aks/).

```hcl
provider "azurerm" {
  features {}
}

module "aparavi" {
  source = "github.com/Aparavi-Operations/aparavi-cloud-receipts.git//modules/azure/aparavi-aks"

  name                 = "aparavi"
  location             = "eastus"
  tags                 = { service : "aparavi" }
  aks_agents_size      = "Standard_B4ms"
  mysql_sku_name       = "GP_Gen5_2"
  platform_host        = "preview.aparavi.com"
  platform_node_id     = "11111111-aaaa-2222-bbbb-333333333333"
  aggregator_node_name = "aggregator"
  collector_node_name  = "collector"
  generate_sample_data = true
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
| <a name="input_aggregator_node_name"></a> [aggregator\_node\_name](#input\_aggregator\_node\_name) | Aggregator node name. Default: "${var.name}-aggregator" | `string` | `""` | no |
| <a name="input_aks_agents_size"></a> [aks\_agents\_size](#input\_aks\_agents\_size) | Virtual machine size for the Kubernetes agents | `string` | `"Standard_B4ms"` | no |
| <a name="input_aparavi_chart_version"></a> [aparavi\_chart\_version](#input\_aparavi\_chart\_version) | Aparavi Helm chart version. Default: latest | `string` | `""` | no |
| <a name="input_collector_node_name"></a> [collector\_node\_name](#input\_collector\_node\_name) | Collector node name. Default: "${var.name}-collector" | `string` | `""` | no |
| <a name="input_generate_sample_data"></a> [generate\_sample\_data](#input\_generate\_sample\_data) | Generate sample data in collector | `bool` | `false` | no |
| <a name="input_location"></a> [location](#input\_location) | Azure location where resources reside | `string` | `"eastus"` | no |
| <a name="input_mysql_sku_name"></a> [mysql\_sku\_name](#input\_mysql\_sku\_name) | The SKU Name for MySQL Server. The name of the SKU follows the<br>tier + family + cores pattern (e.g. B\_Gen4\_1, GP\_Gen5\_8) | `string` | `"GP_Gen5_2"` | no |
| <a name="input_name"></a> [name](#input\_name) | Main name of resources, such as Resource Groups, AKS Cluster,<br>SQL Database... | `string` | `"aparavi"` | no |
| <a name="input_platform_host"></a> [platform\_host](#input\_platform\_host) | Aparavi platform hostname[:port] to connect aggregator to | `string` | n/a | yes |
| <a name="input_platform_node_id"></a> [platform\_node\_id](#input\_platform\_node\_id) | Aparavi platform node ID to connect aggregator to | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to apply to resources | `map(string)` | <pre>{<br>  "service": "aparavi"<br>}</pre> | no |
