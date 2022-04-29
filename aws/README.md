# AWS Terraform deployment

This documentation will show you how to deploy Aparavi applications using Terraform using Linux

## Setup tooling
# Install AWS CLI first

```
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install
```
# Add Hashicorp repository to install Terraform
```
curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
sudo apt-get update
sudo apt-get install terraform
```
# Install git package and download Aparavi repo
```
sudo apt install git
git clone https://github.com/Aparavi-Operations/aparavi-cloud-receipts.git
cd aparavi-cloud-receipts/aws
```

## Configure variables

open aws/VARIABLES.TF and fill default values for all mandatory variables

## Login to AWS
Please follow the official documentation provided by AWS:
https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-quickstart.html#cli-configure-quickstart-config

## Deploy Aparavi applications
```
terraform init && terraform apply
```
