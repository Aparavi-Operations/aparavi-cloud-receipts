terraform {
  required_version = ">= 1.0.7"
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 4.20.0"
    }
  }
}
