# aparavi-cloud-receipts
Here you can deploy Aparavi app with VM GCP instances

## Installation
Please be sure to have gcloud CLI tool installed and configured

You can obtain gcloud CLI [here](https://cloud.google.com/sdk/docs/install)

Gcloud CLI configuation example:
```
gcloud init
gcloud config set project <PROJECT-ID>
gcloud auth application-default login
```
Where PROJECT-ID is your GCP project id.
Be sure to have Terraform installed

You can obtain terraform [here](https://learn.hashicorp.com/tutorials/terraform/install-cli)


Be sure to have ssh keypair at hand, you can generate it with this command (linux only)
Be careful not to overwrite existing keys
```
ssh-keygen -f ~/.ssh/id_rsa_aparavi
```
## Deployment
Review variables.tf contents to make adjustments (project id, VM type, etc)
Review compute.tf to check public ssh key path
Run 
```
terraform init
terraform apply -var="master_user_name=admin" -var="master_user_password=SecUrePassW0rd"  -var="parentid=<APP_PARENT_ID>" -var="bind_addr=<PLATFORM_ADDRESS>" -var="project=<UNIQUE_GOOGLE_PROJECT_ID>"
```
You can obtain APP_PARENT_ID and PLATFORM_ADDRESS values via Aparavi Support Team.
Be sure to store terraform.tfstate file, or use GCP Bucket to save it.
Also you can check terraform outputs to review created resources info
## How to delete
```
terraform destroy -var="master_user_name=admin" -var="master_user_password=SecUrePassW0rd"  -var="parentid=<APP-PARENT-ID>" -var="bind_addr=<PLATFORM_ADDRESS>" -var="project=<UNIQUE_GOOGLE_PROJECT_ID>"
```
## How to connect via bastion ssh host
This applies to linux only,  
edit ~/.ssh/config file like this
```
Host bastion
  User admin
  Hostname [BASTION EXTERNAL IP]
  IdentityFile ~/.ssh/id_rsa_aparavi
Host aggregator
  Hostname 10.105.10.51
  User admin
  ProxyCommand ssh bastion -W %h:%p
  IdentityFile ~/.ssh/id_rsa_aparavi
```
then run
```
ssh aggregator
```
