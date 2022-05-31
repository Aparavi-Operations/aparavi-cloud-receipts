terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.11.0"
    }
  }
}

provider "aws" {
  profile = var.aws_profile
  region  = var.region
}
