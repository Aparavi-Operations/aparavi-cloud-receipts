# Aparavi on Google Cloud Platform (GCP)

## Requirements

Make sure you have downloaded and installed [gcloud CLI](https://cloud.google.com/sdk/gcloud#download_and_install_the). Installation
instructions are available at https://cloud.google.com/sdk/docs/install.
Setting up gcloud CLI instructions are available at
https://cloud.google.com/sdk/docs/initializing. You will need to acquire new
user credentials to use for Application Default Credentials in order for
terraform to authenticate to GCP:

```
gcloud auth application-default login
```

## Organization of GCP cloud receipts

[`gke/`](gke/): Deployment example of Aparavi on Google Kubernetes Engine (GKE)
