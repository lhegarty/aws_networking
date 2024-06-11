variable "vpc_id" {
  description = "The VPC ID to create the subnets in"
}

variable "subnet_cidr_az_mapping" {
  type = map(list(string))
}

variable "cidr_prefix" {
  type = string
}
