terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.66.0"
    }
  }
}

locals {
  flattened_az_to_subnet_map = flatten([
    for az, subnet_list in var.subnet_cidr_az_mapping : [
      for subnet in subnet_list : {
        az     = az
        subnet = subnet
      }
    ]
  ])

  cidr_prefix = var.cidr_prefix
}

resource "aws_subnet" "management_subnets" {
  count             = length(local.flattened_az_to_subnet_map)
  vpc_id            = var.vpc_id
  cidr_block        = "${local.cidr_prefix}${local.flattened_az_to_subnet_map[count.index].subnet}"
  availability_zone = local.flattened_az_to_subnet_map[count.index].az

  tags = {
    Name = "management_subnet-${local.flattened_az_to_subnet_map[count.index].az}_${count.index}"
  }
}
