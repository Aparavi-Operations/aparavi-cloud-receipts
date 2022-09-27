# Aparavi on VMWare VSphere Terraform Module

This module deploys Aparavi on VMWare VSphere. Resources this module will create
are:

- MySQL VM
- Aparavi Aggregator, collector or appagent VM

## Usage

An example usage of this module is also in
[../../../vmware/vsphere/](../../../vmware/vsphere/).

```hcl
provider "vsphere" {
  user                 = "admin"
  password             = "password"
  vsphere_server       = "vsphere.example.com"
  allow_unverified_ssl = true
}

module "aparavi" {
  source = "github.com/Aparavi-Operations/aparavi-cloud-receipts.git//modules/vmware/aparavi-vsphere"

  datacenter       = "datacenter"
  datastore        = "datastore"
  cluster          = "cluster"
  network          = "network"
  template         = "template"
  platform_host    = "preview.aparavi.com"
  platform_node_id = "11111111-aaaa-2222-bbbb-333333333333"
}
```

A VM template with cloud-init must already exist in the cluster. See usage
example in [../../../vmware/vsphere/](../../../vmware/vsphere/) for instructions
on how to import one.

Execute the following commands:

- `terraform init` to get the plugins
- `terraform plan` to see the infrastructure plan
- `terraform apply` to apply the infrastructure build
- `terraform destroy` to destroy the built infrastructure

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aggregator"></a> [aggregator](#input\_aggregator) | Aggregator VM configuration | `map` | <pre>{<br>  "disk_size": 200,<br>  "enabled": false,<br>  "guest_id": "ubuntu64Guest",<br>  "memory": 16384,<br>  "num_cpus": 4<br>}</pre> | no |
| <a name="input_appagent"></a> [appagent](#input\_appagent) | Appagent VM configuration | `map` | <pre>{<br>  "disk_size": 200,<br>  "enabled": true,<br>  "guest_id": "ubuntu64Guest",<br>  "memory": 16384,<br>  "num_cpus": 4<br>}</pre> | no |
| <a name="input_cluster"></a> [cluster](#input\_cluster) | VSphere cluster name to deploy VM's into | `string` | n/a | yes |
| <a name="input_collector"></a> [collector](#input\_collector) | Collector VM configuration | `map` | <pre>{<br>  "disk_size": 200,<br>  "enabled": false,<br>  "guest_id": "ubuntu64Guest",<br>  "memory": 16384,<br>  "num_cpus": 4<br>}</pre> | no |
| <a name="input_datacenter"></a> [datacenter](#input\_datacenter) | VSphere datacenter name to deploy resources into | `string` | n/a | yes |
| <a name="input_datastore"></a> [datastore](#input\_datastore) | VSphere datastore name to use for VM's | `string` | n/a | yes |
| <a name="input_mysql"></a> [mysql](#input\_mysql) | MySQL VM configuration | `map` | <pre>{<br>  "disk_size": 200,<br>  "enabled": true,<br>  "guest_id": "ubuntu64Guest",<br>  "memory": 16384,<br>  "num_cpus": 4<br>}</pre> | no |
| <a name="input_network"></a> [network](#input\_network) | VSphere network name to attach to VM's | `string` | n/a | yes |
| <a name="input_platform_host"></a> [platform\_host](#input\_platform\_host) | Aparavi platform hostname[:port] | `string` | n/a | yes |
| <a name="input_platform_node_id"></a> [platform\_node\_id](#input\_platform\_node\_id) | Aparavi platform node ID | `string` | n/a | yes |
| <a name="input_template"></a> [template](#input\_template) | VM template name to use for VM creation. Must have cloud-init. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_aggregator"></a> [aggregator](#output\_aggregator) | n/a |
| <a name="output_appagent"></a> [appagent](#output\_appagent) | n/a |
| <a name="output_collector"></a> [collector](#output\_collector) | n/a |
| <a name="output_mysql"></a> [mysql](#output\_mysql) | n/a |
