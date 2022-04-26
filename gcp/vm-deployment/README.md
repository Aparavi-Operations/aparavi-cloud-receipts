# aparavi-cloud-receipts
Here you can deploy Aparavi app with VM GCP instances

## Installation
Please be sure to have gcloud CLI tool installed and configured
You can obtain gcloud CLI [here] (https://cloud.google.com/sdk/docs/install)

Gcloud CLI configuation example:
```
gcloud init
gcloud config set project <PROJECT-ID>
gcloud auth application-default login
```
Be sure to have Terraform installed
You can obtain gcloud CLI [here](ttps://learn.hashicorp.com/tutorials/terraform/install-cli)

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
terraform apply -var="master_user_name=admin" -var="master_user_password=SecUrePassW0rd"  -var="parentid=<APP-PARENT-ID>" -var="bind_addr=<PLATFORM_ADDRESS>"
```
You can obtain  <APP-PARENT-ID> and <PLATFORM_ADDRESS> variables via Aparavi Support Team 
be sure to store terraform.tfstate file, or use GCP Bucket to save it
Also you can check terraform outputs to review created resources info
## How to delete
```
terraform destroy -var="master_user_name=admin" -var="master_user_password=SecUrePassW0rd"  -var="parentid=<APP-PARENT-ID>" -var="bind_addr=<PLATFORM_ADDRESS>"
```