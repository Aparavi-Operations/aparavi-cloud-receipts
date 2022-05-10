# Aparavi Kubernetes Terraform Configurations

Terraform configuration files and modules to deploy Aparavi application on
public cloud managed Kubernetes services.

## Requirements

You will need Terraform CLI installed on your system. Packages are available at
https://www.terraform.io/downloads. There is also a tutorial on how to install
Terraform at https://learn.hashicorp.com/tutorials/terraform/install-cli.

## Organization Of Configuration Files

[`aws/`](aws/): Amazon Web Service (AWS) Elastic Kubernetes Service (EKS)

[`gcp/`](gcp/): Google Cloud Platform (GCP) Google Kubernetes Engine (GKE)

`modules/`: Shared Terraform modules
