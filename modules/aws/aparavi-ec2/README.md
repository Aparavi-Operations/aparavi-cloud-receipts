# Aparavi on Amazon Web Services (AWS) Elastic Compute Cloud (EC2) Terraform
# Module

This module deploys Aparavi aggregator and collector on Amazon Web Services
(AWS) Elastic Compute Cloud (EC2). Resources this module will create are:

- VPC, public and private subnets, NAT and Internet gateways
- RDS MySQL instance
- EC2 instances

## Usage

An example usage of this module is also in
[../../../aws/ec2/](../../../aws/ec2/).

```hcl
provider "aws" {
  profile = "my-profile"
  region  = "us-west-1"
}

module "aparavi" {
  source = "github.com/Aparavi-Operations/aparavi-cloud-receipts.git//modules/aws/aparavi-ec2"

  KEY_NAME                 = "my-ec2-key-pair"
  MANAGEMENT_NETWORK       = "0.0.0.0/0"
  PLATFORM                 = "preview.aparavi.com"
  PARENT_ID                = "11111111-aaaa-2222-bbbb-333333333333"
  DEPLOYMENT               = "aparavi"
  collector_instance_count = 1
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
| <a name="input_DEPLOYMENT"></a> [DEPLOYMENT](#input\_DEPLOYMENT) | MANDATORY - Unique name of the deployment. Multiple deployments of this stack in single VPC are supported (e.g. attempt1) | `string` | `""` | no |
| <a name="input_KEY_NAME"></a> [KEY\_NAME](#input\_KEY\_NAME) | MANDATORY - SSH Key name to attach to ec2 instances | `string` | `""` | no |
| <a name="input_MANAGEMENT_NETWORK"></a> [MANAGEMENT\_NETWORK](#input\_MANAGEMENT\_NETWORK) | MANDATORY - Allow connections from Management network (e.g. 0.0.0.0/0 for all incoming connection from the Internet) | `string` | `""` | no |
| <a name="input_PARENT_ID"></a> [PARENT\_ID](#input\_PARENT\_ID) | MANDATORY - activeNodeId from Aparavi Portal | `string` | `""` | no |
| <a name="input_PLATFORM"></a> [PLATFORM](#input\_PLATFORM) | MANDATORY - Platform to attach an aggregator to (e.g. preview.aparavi.com) | `string` | `""` | no |
| <a name="input_collector_instance_count"></a> [collector\_instance\_count](#input\_collector\_instance\_count) | Number of collector instances | `number` | `1` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_aggregator_ssh_address"></a> [aggregator\_ssh\_address](#output\_aggregator\_ssh\_address) | SSH address to connect to aggregator instance |
| <a name="output_bastion_ssh_address"></a> [bastion\_ssh\_address](#output\_bastion\_ssh\_address) | SSH address to connect to bastion instance |
| <a name="output_collector_ssh_addresses"></a> [collector\_ssh\_addresses](#output\_collector\_ssh\_addresses) | List of SSH addresses to connect to collector instances |
| <a name="output_grafana_url"></a> [grafana\_url](#output\_grafana\_url) | Grafana URL |
| <a name="output_monitoring_ssh_address"></a> [monitoring\_ssh\_address](#output\_monitoring\_ssh\_address) | SSH address to connecto to monitoring instance |
