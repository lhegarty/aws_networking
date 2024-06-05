terraform {
  backend "s3" {
    bucket  = "management-account-state-bucket"
    key     = "custom_vpc.tfstate"
    encrypt = true
  }
}
