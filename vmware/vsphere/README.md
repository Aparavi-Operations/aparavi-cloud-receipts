# Aparavi on VMWare VSphere

Terraform configuration files for deploying Aparavi on VMWare VSphere.

## Requirements

You will need Terraform CLI installed on your system. Packages are available at
https://www.terraform.io/downloads. There is also a tutorial on how to install
Terraform at https://learn.hashicorp.com/tutorials/terraform/install-cli.

### VM template

A template from which virtual machines will be created must be present in the
cluster and it should have [cloud-init](https://cloud-init.io/). We have tested
this deployment on
[Ubuntu 22.04 Jammy Jellyfish cloud image](https://cloud-images.ubuntu.com/) but
it should work on any template containing cloud init. You can find instructions
on how to deploy OVA templates at
https://docs.vmware.com/en/VMware-vSphere/7.0/com.vmware.vsphere.vm_admin.doc/GUID-17BEDA21-43F6-41F4-8FB2-E01D275FE9B4.html.
You can use the Ubuntu 22.04 OVA URL directly without downloading it. Just paste
https://cloud-images.ubuntu.com/jammy/current/jammy-server-cloudimg-amd64.ova on
the **Select an OVF template** page and leave everything else with defaults.
Note the **Virtual machine name** you give on **Select a name and folder** page.
You will use that name as the value of the `template` terraform variable. Do not
boot the machine.

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
