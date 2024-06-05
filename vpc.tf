locals {
  az_to_subnet_map = {
    for i in range(length(var.subnet_cidrs)) : element(var.azs, i % length(var.azs)) => var.subnet_cidrs[i]...
  }
  flattened_az_to_subnet_map = flatten([
    for az, subnets in local.az_to_subnet_map : [
      for subnet in subnets : {
        az     = az
        subnet = subnet
      }
    ]
  ])
}

output "name" {
  value = local.flattened_az_to_subnet_map
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





