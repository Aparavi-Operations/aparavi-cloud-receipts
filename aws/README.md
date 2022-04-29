# AWS Terraform deployment

This documentation will show you how to deploy Aparavi applications using Terraform using Linux

## Setup tooling

```
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install
```

```
sudo apt update && sudo apt install terraform git
git clone https://github.com/Aparavi-Operations/aparavi-cloud-receipts.git
cd aparavi-cloud-receipts/aws
```

## Configure variables

open aws/VARIABLES.TF and fill default values for all mandatory variables

## Login to AWS

https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-quickstart.html#cli-configure-quickstart-config

## Deploy Aparavi applications

```
terraform init && terraform apply
```