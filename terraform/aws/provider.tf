terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.81.0"
    }
  }

  required_version = ">= 1.10.3"
}

provider "aws" {
  region  = "us-east-1"
  profile = "NT-devops"
}