# Aparavi on Google Kubernetes Engine (GKE)

## Requirements

You will need Terraform CLI installed on your system. Packages are available at
https://www.terraform.io/downloads. There is also a tutorial on how to install
Terraform at https://learn.hashicorp.com/tutorials/terraform/install-cli.

Make sure you have downloaded and installed [gcloud CLI](https://cloud.google.com/sdk/gcloud#download_and_install_the). Installation
instructions are available at https://cloud.google.com/sdk/docs/install.
Setting up gcloud CLI instructions are available at
https://cloud.google.com/sdk/docs/initializing. You will need to acquire new
user credentials to use for Application Default Credentials in order for
terraform to authenticate to GCP:

```
gcloud auth application-default login
```

## Configuration, deployment and destroy

Input variables are listed in [variables.tf](./variables.tf). There is an
[example.tfvars](./example.tfvars) variable definitions file, which describes
the minimal set of variables you'll most likely want to override.

### Deploy

Assuming you put terraform variable definitions in `override.tfvars` file:

```
terraform init
terraform apply -var-file=override.tfvars
```

This will deploy Aparavi aggregator and collector on EKS, along with all
required resources, such as VPC Network and Cloud SQL. Aggregator and collector
will be visible shortly after in platform UI you pointed `platform_host`
terraform variable to.

### Destroy

```
terraform destroy -var-file=override.tfvars
```
