 provider "google" {

    project = var.project 
    region  = var.region
    zone    = var.zone
  }
   provider "google-beta" {

    project = var.project 
    region  = var.region
    zone    = var.zone
  }
terraform {
  required_version = ">= 0.12.26"

  required_providers {
    google-beta = {
      source  = "hashicorp/google-beta"
    }
  }
}