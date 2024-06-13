terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.66.0"
    }
  }
}

provider "aws" {
  alias   = "management-admin"
  region  = var.region
  profile = var.aws_account_profiles["management"]
}

provider "aws" {
  alias   = "sb1"
  region  = var.region
  profile = var.aws_account_profiles["sb1"]
}

provider "aws" {
  alias   = "sb2"
  region  = var.region
  profile = var.aws_account_profiles["sb2"]
}
