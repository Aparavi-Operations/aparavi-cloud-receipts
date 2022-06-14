# Aparavi on Google Kubernetes Engine (GKE) Terraform Module

This module deploys Aparavi aggregator and collector on Google Kubernetes
Engine (GKE). Resources this module will create are:

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
| <a name="input_aggregator_node_name"></a> [aggregator\_node\_name](#input\_aggregator\_node\_name) | Aggregator node name | `string` | `"aggregator"` | no |
| <a name="input_cloudsql_tier"></a> [cloudsql\_tier](#input\_cloudsql\_tier) | The machine type to use in Cloud SQL instance | `string` | `"db-f1-micro"` | no |
| <a name="input_collector_node_name"></a> [collector\_node\_name](#input\_collector\_node\_name) | Collector node name | `string` | `"collector"` | no |
| <a name="input_generate_sample_data"></a> [generate\_sample\_data](#input\_generate\_sample\_data) | Generate sample data for collector | `bool` | `false` | no |
| <a name="input_gke_machine_type"></a> [gke\_machine\_type](#input\_gke\_machine\_type) | GCE machine type name to use in default node group | `string` | `"custom-8-16384"` | no |
| <a name="input_labels"></a> [labels](#input\_labels) | Labels to apply to resources that support it | `map(string)` | <pre>{"service": "aparavi"}</pre> | no |
| <a name="input_name"></a> [name](#input\_name) | Main name of resources, such as network, GKE cluster, Cloud SQl... | `string` | `"aparavi"` | no |
| <a name="input_platform_host"></a> [platform\_host](#input\_platform\_host) | Aparavi platform host to connect aggregator to | `string` | n/a | yes |
| <a name="input_platform_node_id"></a> [platform\_node\_id](#input\_platform\_node\_id) | Aparavi platform node ID to connect aggregator to | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | GCP region where resources reside | `string` | `"us-west1"` | no |
| <a name="input_zone"></a> [zone](#input\_zone) | GCP zone to deploy GKE cluster in | `string` | `"us-west1-a"` | no |
