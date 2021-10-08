data "aws_caller_identity" "default" {}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

provider "aws" {
  region  = "us-east-1"
}

locals {
  prefix    = "ddvpcs-"
}
