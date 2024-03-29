# Aparavi on Exoscale VM Terraform Module

## Usage

An example usage of this module is also in [../../../exoscale/instances/](../../../exoscale/instances/).

```hcl
provider "exoscale" {
  key     = "EXOxxxxxxxxxxxxxxxxxxxxxxxx"
  secret  = "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
}

module "aparavi" {
  source = "github.com/Aparavi-Operations/aparavi-cloud-receipts.git//modules/exoscale/aparavi-instances"

  zone                 = "de-muc-1"
  name                 = "aparavi"
  sks_instance_type    = "standard.extra-large"
  dbaas_plan           = "hobbyist-2"
  platform_host        = "preview.aparavi.com"
  platform_node_id     = "11111111-aaaa-2222-bbbb-333333333333"
  appagent_node_name   = "appagent"
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
| <a name="input_appagent_node_name"></a> [aggregator\_node\_name](#input\_aggregator\_node\_name) | Aggregator node name. Default: "${var.name}-aggregator" | `string` | `""` | no |
| <a name="input_dbaas_plan"></a> [dbaas\_plan](#input\_dbaas\_plan) | The plan of the database service | `string` | `"hobbyist-2"` | no |
| <a name="input_name"></a> [name](#input\_name) | Main name of resources, such as SKS, DBAAS, etc | `string` | `"aparavi"` | no |
| <a name="input_platform_host"></a> [platform\_host](#input\_platform\_host) | Aparavi platform hostname[:port] to connect aggregator to | `string` | n/a | yes |
| <a name="input_platform_node_id"></a> [platform\_node\_id](#input\_platform\_node\_id) | Aparavi platform node ID to connect aggregator to | `string` | n/a | yes |
| <a name="input_zone"></a> [zone](#input\_zone) | Exoscale zone name | `string` | `"de-muc-1"` | no |
