# Aparavi on Google Kubernetes Engine (GKE)

## Requirements

Make sure you have installed and configured [terraform](../../README.md#requirements) and [gcloud CLI](../README.md#requirements).

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
