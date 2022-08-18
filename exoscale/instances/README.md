# aparavi-cloud-receipts
Here you can deploy Aparavi app with VM Exoscale instances

## Installation
Be sure to have Terraform installed

You can obtain terraform [here](https://learn.hashicorp.com/tutorials/terraform/install-cli)


Be sure to have ssh keypair at hand, you can generate it with this command (linux only)
Be careful not to overwrite existing keys
```
ssh-keygen -f ~/.ssh/id_rsa_aparavi
cat ~/.ssh/id_rsa_aparavi.pub
```
Obtain and install Exoscale CLI [here](https://community.exoscale.com/documentation/tools/exoscale-command-line-interface/)

## Preparation
Be sure to install Aparavi custom template
```
exo compute instance-template register aparavi-custom-template https://aparavi.jfrog.io/artifactory/aparavi-images/aparavi-hardened.qcow2 57d11cb19c2648851c40a6688ef2f141 --description "Aparavi custom template"
```
Note, that you will need separate custom template for each region

## Deployment
Review terraform.tfvars or variables.tf contents to make adjustments (project id, VM type, etc)
save contents of key file to terraform.tfvars to variable called "public_key"
Be sure to save Exoscale API key and API secret to terraform.tfvars
You can obtain Exoscale API key and API secret in Exscale UI
Adjust settings in terraform.tfvars to fit your environment, don`t forget to set your public ssh key


Run 
```
terraform init
```
You can obtain platform_node_id and platform_host values via Aparavi Support Team.
Be sure to store terraform.tfstate file.
## How to delete
```
terraform destroy
```
## How to connect via bastion ssh host
This applies to linux only,  
edit ~/.ssh/config file like this
```
Host bastion
  User admin
  Hostname [BASTION EXTERNAL IP]
  IdentityFile ~/.ssh/id_rsa_aparavi
Host appagent
  Hostname 192.168.100.5
  User admin
  ProxyCommand ssh bastion -W %h:%p
  IdentityFile ~/.ssh/id_rsa_aparavi
```
You can obtain Bastion host external ip in Exoscale UI
then run
```
ssh appagent
```
