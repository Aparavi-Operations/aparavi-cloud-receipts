terraform {
  required_version = "~> 1.0.7"
  required_providers {
    helm = {
      source  = "hashicorp/helm"
      version = "~>2.5.1"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~>2.11.0"
    }
  }
}

provider "kubernetes" {
  config_path    = "~/.kube/config"
  config_context = var.kubectl_config_context
}

provider "helm" {
  kubernetes {
    config_path    = "~/.kube/config"
    config_context = var.kubectl_config_context
  }
}
