# Aparavi on Exoscale Scalable Kubernetes Service (SKS)

Terraform configuration files for deploying Aparavi on Exoscale Scalable
Kubernetes Service (AKS).

## Requirements

You will need Terraform CLI installed on your system. Packages are available at
https://www.terraform.io/downloads. There is also a tutorial on how to install
Terraform at https://learn.hashicorp.com/tutorials/terraform/install-cli.

You will need to generate Exoscale API key and secret and provide as input
variables to Terraform. See
https://community.exoscale.com/documentation/iam/quick-start/ for more info on
generating API key and secret.

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

This will deploy Aparavi aggregator and collector on SKS, along with all
required resources, such as Private Network and DBaaS MySQL Service. Aggregator
and collector will be visible shortly after in platform UI you pointed
`platform_host` terraform variable to.

### Destroy

```
terraform destroy -var-file=override.tfvars
```
