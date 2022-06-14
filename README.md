# Aparavi Cloud Receipts

Terraform configuration files and modules to deploy Aparavi application on
public cloud services.

## Directory Structure

***Aparavi Classic*** available in:
* [`aws/`](aws/): Amazon Web Service (AWS)
* [`gcp/`](gcp/): Google Cloud Platform (GCP)
* [`azure/`](azure/): Azure
* [`exoscale/`](exoscale/): Exoscale
* [`kvm/`](kvm/): Baremetal KVM

***Aparavi Connect*** available in:
* [`aparavi-connect/ec2/`](aparavi-connect/ec2/): Amazon Web Service (AWS) EC2
* [`aparavi-connect/gcp/`](aparavi-connect/gcp/): Google Cloud Platform (GCP)
* [`aparavi-connect/azure/`](aparavi-connect/azure/): Azure

Terraform modules which are used to deploy projects:
* [`modules/`](modules/)

Monitoring configuration templates (Docker Compose, Grafana, Victoria Metrics, Prometheus):
* [`monitoring/`](monitoring/)