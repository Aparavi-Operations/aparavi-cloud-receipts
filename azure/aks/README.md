# Aparavi on Azure Kubernetes Service (AKS)

## Requirements

You will need Terraform CLI installed on your system. Packages are available at
https://www.terraform.io/downloads. There is also a tutorial on how to install
Terraform at https://learn.hashicorp.com/tutorials/terraform/install-cli.

Make sure you have installed
[Azure CLI](https://docs.microsoft.com/en-us/cli/azure/).
Installation instructions are available at
https://docs.microsoft.com/en-us/cli/azure/install-azure-cli
You should also make sure you are signed in sith Azure CLI. Any method described
at https://docs.microsoft.com/en-us/cli/azure/authenticate-azure-cli should do.

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
