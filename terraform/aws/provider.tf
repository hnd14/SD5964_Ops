terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.70.0"
    }
  }

  required_version = ">= 1.10.3"
}

provider "aws" {
  region  = "ap-southeast-1"
  profile = "NT-devops"
}