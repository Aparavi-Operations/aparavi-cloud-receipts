# Azure VM terraform deploy code
By default it will create Application in this configuration:

1. AppAgent (Aggregator + Collector on one instance)
2. Three workers connected to the AppAgent
3. Monitoring solition (Graphana dashboard, NodeExportes, vmagent, vmalert, and alermanager)

To change this configuration you can set variables `appagent` and `workers` in `main.tf` file to `false`.

## How-to use

1. Prepare Variables file (ese example.tfvars as reference).   
   Service principal credentials usage is expected.

2. Initialize Terraform modules   
   `terraform init`

3. Run Terraform   
   `terraform apply -var-file=example.tfvars`

4. Use output information to connect to monitoring dashboard and instances   

**Note** you can copy and paste ssh section from generated output to your `.ssh/config` file, and connect to newly created hosts over ssh.

## Destroying

`terraform destroy -var-file=example.tfvars`   
It can be required to run destroy multiple times due to timeouts and async deletion.   

**Note** in some cases you need to run `terraform destroy` several times to destroy everything due of normal behavior of Azure terraform provider.