locals {
  flattened_az_to_subnet_map = flatten([
    for az, subnet_list in var.subnet_cidr_az_mapping : [
      for subnet in subnet_list : {
        az     = az
        subnet = subnet
      }
    ]
  ])
}

#################
# VPC resources #
#################

resource "aws_vpc" "custom_management_vpc" {
  cidr_block = "10.16.0.0/16"
  tags = {
    Name = "management_vpc"
  }
}

resource "aws_subnet" "management_subnets" {
  count             = length(local.flattened_az_to_subnet_map)
  vpc_id            = aws_vpc.custom_management_vpc.id
  cidr_block        = local.flattened_az_to_subnet_map[count.index].subnet
  availability_zone = local.flattened_az_to_subnet_map[count.index].az

  tags = {
    Name = "management_subnet-${local.flattened_az_to_subnet_map[count.index].az}_${count.index}"
  }
}





