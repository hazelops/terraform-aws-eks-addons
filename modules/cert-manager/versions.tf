terraform {
  required_version = ">= 1.5.7"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.84"
    }
    helm = {
      source  = "hashicorp/helm"
      version = ">= 3.0"
    }
  }
}
