# Aparavi on Azure Kubernetes Service (AKS) Terraform Module

This module deploys Aparavi appagent on Azure Kubernetes Service (AKS).
Resources this module will create are:

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
  appagent_node_name = "appagent"
  data_sources = {
    s1 = {
      type = "azure"
      fs_type = "ext4"
      volume_handle = "/subscriptions/01234567-0123-0123-0123-0123456789ab/resourceGroups/myResourceGroup/providers/Microsoft.Compute/disks/myDisk"
    }
    s2 = {
      type          = "nfs"
      server        = "10.10.10.10"
      path          = "/"
      mount_options = [
        "nfsvers=4.2"
      ]
    }
    s3 = {
      type          = "smb"
      source        = "//10.10.10.10/data"
      mount_options = []
      username      = "user"
      password      = "pass"
    }
  }
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
| <a name="input_appagent_node_name"></a> [appagent\_node\_name](#input\_appagent\_node\_name) | Appagent node name. Default: "${var.name}-appagent" | `string` | `""` | no |
| <a name="input_aks_agents_size"></a> [aks\_agents\_size](#input\_aks\_agents\_size) | Virtual machine size for the Kubernetes agents | `string` | `"Standard_B4ms"` | no |
| <a name="input_data_sources"></a> [data\_sources](#data\_sources) | Data sources to mount into appagent pod | `any` | `{}` | no |
| <a name="input_location"></a> [location](#input\_location) | Azure location where resources reside | `string` | `"eastus"` | no |
| <a name="input_mysql_sku_name"></a> [mysql\_sku\_name](#input\_mysql\_sku\_name) | The SKU Name for MySQL Server. The name of the SKU follows the<br>tier + family + cores pattern (e.g. B\_Gen4\_1, GP\_Gen5\_8) | `string` | `"GP_Gen5_2"` | no |
| <a name="input_name"></a> [name](#input\_name) | Main name of resources, such as Resource Groups, AKS Cluster,<br>SQL Database... | `string` | `"aparavi"` | no |
| <a name="input_platform_host"></a> [platform\_host](#input\_platform\_host) | Aparavi platform hostname[:port] | `string` | n/a | yes |
| <a name="input_platform_node_id"></a> [platform\_node\_id](#input\_platform\_node\_id) | Aparavi platform node ID | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to apply to resources | `map(string)` | <pre>{<br>  "service": "aparavi"<br>}</pre> | no |

### [data_sources](#input_data_sources)

See [usage](#usage) example for full format and options. In general, this is an object
with arbitrary keys. The keys are used as PV and PVC names in Kubernetes and
mount point directories under `/opt/data` in appagent pod. For example,

```hcl
s1 = {
  type          = "nfs"
  server        = "10.10.10.10"
  path          = "/"
  mount_options = [
    "nfsvers=4.2"
  ]
}
```
will create a PV and a PVC both named `s1` and mount the PVC under
`/opt/data/s1`.

The `type` attribute is what distinguishes between different external data
sources and determines the overall object structure of the value.
[Usage](#usage) example demonstrates the full structure.
