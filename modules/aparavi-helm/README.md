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
  mysql_username       = "aparavi"
  mysql_password       = "aparavi"
  platform_host        = "platform.example.com"
  platrofm_node_id     = "11111111-aaaa-1111-aaaa-111111111111"
  appagent_node_name   = "appagent"
  data_sources = {
    s1 = {
      type          = "nfs"
      server        = "10.10.10.10"
      path          = "/"
      mount_options = [
        "nfsvers=4.2"
      ]
    }
    s2 = {
      type          = "smb"
      source        = "//10.10.10.10/data"
      mount_options = []
      username      = "user"
      password      = "pass"
    }
    s3 = {
      type      = "ebs"
      fs_type   = "ext4"
      volume_id = "vol-0123456789abcdef1"
    }
    s4 = {
      type = "gce"
      fs_type = "ext4"
      pd_name = "my-pd"
    }
    s5 = {
      type = "azure"
      fs_type = "ext4"
      volume_handle = "/subscriptions/01234567-0123-0123-0123-0123456789ab/resourceGroups/myResourceGroup/providers/Microsoft.Compute/disks/myDisk"
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
| <a name="input_appagent_node_name"></a> [appagent\_node\_name](#input\_appagent\_node\_name) | Appagent node name. Default: chart default | `string` | `""` | no |
| <a name="input_appagent_node_selector"></a> [appagent\_node\_selector](#input\_appagent\_node\_selector) | Appagent pod's nodeSelector. | `map(string)` | `{}` | no |
| <a name="input_chart_version"></a> [chart\_version](#input\_chart\_version) | Aparavi Helm chart version. Default: latest | `string` | `""` | no |
| <a name="input_data_sources"></a> [data\_sources](#data\_sources) | Data sources to mount into appagent pod | `any` | `{}` | no |
| <a name="input_mysql_hostname"></a> [mysql\_hostname](#input\_mysql\_hostname) | MySQL hostname for aggregator | `string` | n/a | yes |
| <a name="input_mysql_password"></a> [mysql\_password](#input\_mysql\_password) | MySQL password for aggregator | `string` | n/a | yes |
| <a name="input_mysql_port"></a> [mysql\_port](#input\_mysql\_port) | MySQL port | `number` | `3306` | no |
| <a name="input_mysql_username"></a> [mysql\_username](#input\_mysql\_username) | MySQL username for aggregator | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | Helm release name | `string` | `"aparavi"` | no |
| <a name="input_platform_host"></a> [platform\_host](#input\_platform\_host) | Aparavi platform host[:port] | `string` | n/a | yes |
| <a name="input_platform_node_id"></a> [platform\_node\_id](#input\_platform\_node\_id) | Aparavi platform node ID | `string` | n/a | yes |

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
