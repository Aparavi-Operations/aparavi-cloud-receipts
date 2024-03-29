# Aparavi on Google Kubernetes Engine (GKE) Terraform Module

This module deploys Aparavi appagent on Google Kubernetes Engine (GKE).
Resources this module will create are:

- VPC Network and a private subnetwork.
- Cloud NAT
- GKE cluster and GKE Node Pool
- Cloud SQL instance
- Aparavi Helm release

## Usage

An example usage of this module is also in [../../../gcp/gke/](../../../gcp/gke/).

```hcl
provider "google" {
  project = "my-project-id"
}

provider "google-beta" {
  project = "my-project-id"
}

module "aparavi" {
  source = "github.com/Aparavi-Operations/aparavi-cloud-receipts.git//modules/gcp/aparavi-gke"

  name                 = "aparavi"
  region               = "us-west1"
  zone                 = "us-west1-b"
  labels               = { service : "aparavi" }
  gke_machine_type     = "custom-8-16384"
  cloudsql_tier        = "db-f1-micro"
  platform_host        = "preview.aparavi.com"
  platform_node_id     = "11111111-aaaa-2222-bbbb-333333333333"
  appagent_node_name   = "appagent"
  data_sources = {
    s1 = {
      type = "gce"
      fs_type = "ext4"
      pd_name = "my-pd"
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
| <a name="input_appagent_node_name"></a> [appagent\_node\_name](#input\_appagent\_node\_name) | Appagent node name | `string` | `"appagent"` | no |
| <a name="input_cloudsql_tier"></a> [cloudsql\_tier](#input\_cloudsql\_tier) | The machine type to use in Cloud SQL instance | `string` | `"db-f1-micro"` | no |
| <a name="input_data_sources"></a> [data\_sources](#data\_sources) | Data sources to mount into appagent pod | `any` | `{}` | no |
| <a name="input_gke_machine_type"></a> [gke\_machine\_type](#input\_gke\_machine\_type) | GCE machine type name to use in default node group | `string` | `"custom-8-16384"` | no |
| <a name="input_labels"></a> [labels](#input\_labels) | Labels to apply to resources that support it | `map(string)` | <pre>{"service": "aparavi"}</pre> | no |
| <a name="input_name"></a> [name](#input\_name) | Main name of resources, such as network, GKE cluster, Cloud SQl... | `string` | `"aparavi"` | no |
| <a name="input_platform_host"></a> [platform\_host](#input\_platform\_host) | Aparavi platform host | `string` | n/a | yes |
| <a name="input_platform_node_id"></a> [platform\_node\_id](#input\_platform\_node\_id) | Aparavi platform node ID | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | GCP region where resources reside | `string` | `"us-west1"` | no |
| <a name="input_zone"></a> [zone](#input\_zone) | GCP zone to deploy GKE cluster in | `string` | `"us-west1-a"` | no |

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
