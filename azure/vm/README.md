# Azure VM terraform deploy code

## How-to use

1. Prepare Variables file (ese example.tfvars as reference).
   Service principal credentials usage is expected.

2. Initialize Terraform modules
   `terraform init`

3. Run Terraform
   `terraform apply -var-file=<your_tfvars_file>`

4. Use output information to connect to monitoring dashboard and instances

## Destroying

`terraform destroy -var-file=<your_tfvars_file>`
It can be required to run destroy multiple times due to timeouts and async deletion.
