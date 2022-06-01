## AWS Terraform deployment

This documentation will show you how to deploy Aparavi applications using Terraform using Linux

# Prerequirenments to run this project

## Requirements to run this project

## Debian 11 AMD 64 AMI
For this AWS project we use Official Free of Charge Debian 11 image you can get by this [link](https://aws.amazon.com/marketplace/pp/prodview-l5gv52ndg5q6i)   
It is free, just click to **subscribe button** and you will be able to run this project. 

## Install git package and download Aparavi repo
```
sudo apt install git
git clone https://github.com/Aparavi-Operations/aparavi-cloud-receipts.git
cd aparavi-cloud-receipts/aparavi-connect/ec2
```
## Install Terraform

You will need Terraform CLI installed on your system. Packages are available at
https://www.terraform.io/downloads. There is also a tutorial on how to install
Terraform at https://learn.hashicorp.com/tutorials/terraform/install-cli.

## Install AWS Cli
This module relies on AWS CLI local configuration files (`.aws` directory). More
info on installing and configuring AWS CLI is available at
https://aws.amazon.com/cli/

## Set AWS Profile
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

# Configuration, deployment and destroy

Input variables are listed in [variables.tf](./variables.tf). There is an
[example.tfvars](./example.tfvars) variable definitions file, which describes
the minimal set of variables you'll most likely want to override.

### Deploy

Assuming you put terraform variable definitions in `override.tfvars` file:

```
terraform init
terraform apply -var-file=override.tfvars
```

This will deploy Aparavi AppAgent on AWS EC2, along with all
required resources, such as VPC and RDS. AppAgent will be
visible shortly after in platform UI you pointed `PLATFORM` terraform
variable to.

### Destroy

To destroy everything this module created run:   

```
terraform destroy -var-file=override.tfvars
```

