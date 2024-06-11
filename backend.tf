terraform {
  backend "s3" {
    profile = "management-admin"
    bucket  = "management-account-state-bucket"
    key     = "custom_vpc.tfstate"
    encrypt = true
  }
}
