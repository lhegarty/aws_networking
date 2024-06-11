variable "region" {
  type    = string
  default = "eu-west-1"
}

variable "aws_account_profiles" {
  description = "AWS accounts"
  type        = map(string)
  default = {
    management = "management-admin"
    sb1        = "sb1"
    sb2        = "sb2"
  }
}

variable "aws_account_aliases" {
  description = "AWS account aliases"
  type        = map(string)
  default = {
    management = "management-admin"
    sb1        = "sb1"
    sb2        = "sb2"
  }
}

variable "cidr_prefix" {
  description = "The CIDR block for the VPC"
  type        = map(string)
  default = {
    management = "10.16"
    sb1        = "10.32"
    sb2        = "10.48"
  }
}


variable "subnet_cidr_az_mapping" {
  type = map(list(string))
  default = {
    "eu-west-1a" = [
      ".0.0/20",
      ".16.0/20",
      ".32.0/20",
      ".48.0/20",
      ".64.0/20",
      ".80.0/20",
    ],
    "eu-west-1b" = [
      ".96.0/20",
      ".112.0/20",
      ".128.0/20",
      ".144.0/20",
      ".160.0/20",
    ],
    "eu-west-1c" = [
      ".176.0/20",
      ".192.0/20",
      ".208.0/20",
      ".224.0/20",
      ".240.0/20"
    ]
  }
}





