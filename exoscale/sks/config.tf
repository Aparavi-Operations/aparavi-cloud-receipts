terraform {
  required_providers {
    exoscale = {
      source  = "exoscale/exoscale"
      version = "~> 0.36.0"
    }
  }
}

provider "exoscale" {
  key    = var.api_key
  secret = var.api_secret
}
