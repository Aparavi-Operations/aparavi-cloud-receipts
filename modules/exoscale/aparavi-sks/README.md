# Aparavi on Exoscale Scalable Kubernetes Service (SKS) Terraform Module

This module deploys Aparavi appagent on Exoscale Scalable
Kubernetes Service (SKS). Resources this module will create are:

- Private Network
- SKS cluster and SKS Node Pool
- DBaaS MySQL instance
- Aparavi Helm release

## Usage

An example usage of this module is also in [../../../exoscale/sks/](../../../exoscale/sks/).

```hcl
provider "exoscale" {
  key     = "EXOxxxxxxxxxxxxxxxxxxxxxxxx"
  secret  = "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
}

module "aparavi" {
  source = "github.com/Aparavi-Operations/aparavi-cloud-receipts.git//modules/exoscale/aparavi-sks"

  zone                 = "de-muc-1"
  name                 = "aparavi"
  sks_instance_type    = "standard.extra-large"
  dbaas_plan           = "hobbyist-2"
  platform_host        = "preview.aparavi.com"
  platform_node_id     = "11111111-aaaa-2222-bbbb-333333333333"
  appagent_node_name   = "appagent"
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
| <a name="input_appagent_node_name"></a> [appagent\_node\_name](#input\_appagent\_node\_name) | Appagent node name. Default: "${var.name}-appagent" | `string` | `""` | no |
| <a name="input_dbaas_plan"></a> [dbaas\_plan](#input\_dbaas\_plan) | The plan of the database service | `string` | `"hobbyist-2"` | no |
| <a name="input_generate_sample_data"></a> [generate\_sample\_data](#input\_generate\_sample\_data) | Generate sample data in collector | `bool` | `false` | no |
| <a name="input_name"></a> [name](#input\_name) | Main name of resources, such as SKS, DBAAS, etc | `string` | `"aparavi"` | no |
| <a name="input_platform_host"></a> [platform\_host](#input\_platform\_host) | Aparavi platform hostname[:port] | `string` | n/a | yes |
| <a name="input_platform_node_id"></a> [platform\_node\_id](#input\_platform\_node\_id) | Aparavi platform node ID | `string` | n/a | yes |
| <a name="input_sks_instance_type"></a> [sks\_instance\_type](#input\_sks\_instance\_type) | Type of Compute instances managed by the SKS default Nodepool | `string` | `"standard.extra-large"` | no |
| <a name="input_zone"></a> [zone](#input\_zone) | Exoscale zone name | `string` | `"de-muc-1"` | no |
