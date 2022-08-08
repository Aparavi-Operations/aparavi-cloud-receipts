# Aparavi on Amazon Web Services (AWS) Elastic Kubernetes Service (EKS)
# Terraform Module

This module deploys Aparavi appagent on Amazon Web Services (AWS) Elastic
Kubernetes Service (EKS). Resources this module will create are:

- VPC, public and private subnets, NAT and Internet gateways
- EKS cluster and EKS Node Pool
- RDS MySQL instance
- Aparavi Helm release

## Usage

An example usage of this module is also in
[../../../aws/eks/](../../../aws/eks/).

```hcl
provider "aws" {
  profile = "my-profile"
  region  = "us-west-1"
}

module "aparavi" {
  source = "github.com/Aparavi-Operations/aparavi-cloud-receipts.git//modules/aws/aparavi-eks"

  name                      = "aparavi"
  tags                      = { service = "aparavi" }
  eks_instance_types        = ["t3.2xlarge"]
  rds_instance_class        = "db.t4g.micro"
  rds_allocated_storage     = 10
  rds_max_allocated_storage = 1000
  platform_host             = "preview.aparavi.com"
  platform_node_id          = "11111111-aaaa-2222-bbbb-333333333333"
  appagent_node_name        = "appagent"
  data_sources = {
    s1 = {
      type      = "ebs"
      fs_type   = "ext4"
      volume_id = "vol-0123456789abcdef1"
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
| <a name="input_aparavi_chart_version"></a> [aparavi\_chart\_version](#input\_aparavi\_chart\_version) | Aparavi Helm chart version. Default: latest | `string` | `""` | no |
| <a name="input_appagent_node_name"></a> [appagent\_node\_name](#input\_appagent\_node\_name) | Appagent node name. Default: "${var.name}-appagent" | `string` | `""` | no |
| <a name="input_azs"></a> [azs](#input\_azs) | List of desired availability zones names or ids to deploy subnets in | `list(string)` | `[]` | no |
| <a name="input_data_sources"></a> [data\_sources](#data\_sources) | Data sources to mount into appagent pod | `any` | `{}` | no |
| <a name="input_eks_instance_types"></a> [eks\_instance\_types](#input\_eks\_instance\_types) | Set of instance types associated with default Node Group. | `list(string)` | <pre>[<br>  "t3.2xlarge"<br>]</pre> | no |
| <a name="input_name"></a> [name](#input\_name) | Name of most of resources | `string` | `"aparavi"` | no |
| <a name="input_platform_host"></a> [platform\_host](#input\_platform\_host) | Aparavi platform hostname[:port] | `string` | n/a | yes |
| <a name="input_platform_node_id"></a> [platform\_node\_id](#input\_platform\_node\_id) | Aparavi platform node ID | `string` | n/a | yes |
| <a name="input_rds_allocated_storage"></a> [rds\_allocated\_storage](#input\_rds\_allocated\_storage) | RDS allocated storage in gigabytes | `number` | `10` | no |
| <a name="input_rds_instance_class"></a> [rds\_instance\_class](#input\_rds\_instance\_class) | The instance type of the RDS instance | `string` | `"db.t4g.micro"` | no |
| <a name="input_rds_max_allocated_storage"></a> [rds\_max\_allocated\_storage](#input\_rds\_max\_allocated\_storage) | The upper limit of RDS allocated storage in gigabytes | `number` | `1000` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Map of tags to add to all resources | `map(string)` | `{}` | no |
| <a name="input_vpc_cidr"></a> [vpc\_cidr](#input\_vpc\_cidr) | The CIDR block for the VPC | `string` | `"10.0.0.0/16"` | no |
| <a name="input_vpc_private_subnet_cidrs"></a> [vpc\_private\_subnet\_cidrs](#input\_vpc\_private\_subnet\_cidrs) | A list of private subnets inside the VPC. EKS nodes and RDS will be deployed<br>in these subnets | `list(string)` | <pre>[<br>  "10.0.1.0/24",<br>  "10.0.2.0/24"<br>]</pre> | no |
| <a name="input_vpc_public_subnet_cidrs"></a> [vpc\_public\_subnet\_cidrs](#input\_vpc\_public\_subnet\_cidrs) | A list of public subnets inside the VPC | `list(string)` | <pre>[<br>  "10.0.3.0/24"<br>]</pre> | no |

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
