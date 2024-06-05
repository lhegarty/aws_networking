variable "region" {
  type    = string
  default = "us-east-1"
}

variable "keybase_account" {
  type = string
}

variable "account_alias" {
  type = string
}

variable "aws_profile" {
  type = string
}

variable "subnet_cidrs" {
  type = list(string)
  default = [
    "10.16.0.0/20",
    "10.16.16.0/20",
    "10.16.32.0/20",
    "10.16.48.0/20",
    "10.16.64.0/20",
    "10.16.80.0/20",
    "10.16.96.0/20",
    "10.16.112.0/20",
    "10.16.128.0/20",
    "10.16.144.0/20",
    "10.16.160.0/20",
    "10.16.176.0/20",
    "10.16.192.0/20",
    "10.16.208.0/20",
    "10.16.224.0/20",
    "10.16.240.0/20"
  ]
}

variable "azs" {
  type = list(string)
  default = [
    "us-east-1a",
    "us-east-1b",
    "us-east-1c",
  ]
}


