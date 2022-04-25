 provider "google" {
    credentials = file(var.gcp_credentials)
    project = var.project 
    region  = var.region
    zone    = var.zone
  }
   provider "google-beta" {
    credentials = file(var.gcp_credentials)
    project = var.project 
    region  = var.region
    zone    = var.zone
  }
terraform {
  # This module is now only being tested with Terraform 1.0.x. However, to make upgrading easier, we are setting
  # 0.12.26 as the minimum version, as that version added support for required_providers with source URLs, making it
  # forwards compatible with 1.0.x code.
  required_version = ">= 0.12.26"

  required_providers {
    google-beta = {
      source  = "hashicorp/google-beta"
    }
  }
}