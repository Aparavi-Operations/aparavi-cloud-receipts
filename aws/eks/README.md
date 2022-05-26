# Aparavi On AWS EKS Terraform Module

Terraform configuration files and modules for deploying Aparavi application on
AWS EKS.

## Requirements

You will need Terraform CLI installed on your system. Packages are available at
https://www.terraform.io/downloads. There is also a tutorial on how to install
Terraform at https://learn.hashicorp.com/tutorials/terraform/install-cli.

This module relies on AWS CLI local configuration files (`.aws` directory). More
info on installing and configuring AWS CLI is available at
https://aws.amazon.com/cli/

You will need to point your AWS CLI `[default]` profile to the AWS account you
want to deploy this module on. Alternatively, you can set the `aws_profile`
terraform variable to AWS CLI profile you want to use. For example:

```
terraform apply -var=aws_profile=my-profile ...
```

Yet another option is to export `AWS_PROFILE` environment variable:

```
export AWS_PROFILE=my-profile
terraform apply ...
```

`aws sts get-caller-identity` might be useful in determinig where your AWS CLI
points to.

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
required resources, such as VPC and RDS. Aggregator and collector will be
visible shortly after in platform UI you pointed `platform_host` terraform
variable to.

### Destroy

```
terraform destroy -var-file=override.tfvars
```
