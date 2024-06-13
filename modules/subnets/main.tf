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

  public_subnet_cidrs  = [for az in var.subnet_cidr_az_mapping : "${var.cidr_prefix}${az[0]}"]
  private_subnet_cidrs = [for az in var.subnet_cidr_az_mapping : "${var.cidr_prefix}${az[1]}"]
  subnet_cidr_map      = { for subnet in aws_subnet.vpc_subnets : subnet.id => subnet.cidr_block }
  public_subnets       = [for id, cidr in local.subnet_cidr_map : id if contains(local.public_subnet_cidrs, cidr)]
  private_subnets      = [for id, cidr in local.subnet_cidr_map : id if contains(local.private_subnet_cidrs, cidr)]

}

resource "aws_subnet" "vpc_subnets" {
  count             = length(local.flattened_az_to_subnet_map)
  vpc_id            = var.vpc_id
  cidr_block        = "${local.cidr_prefix}${local.flattened_az_to_subnet_map[count.index].subnet}"
  availability_zone = local.flattened_az_to_subnet_map[count.index].az

  tags = merge(
    {
      "Name" = "${format("%s", var.name)}-${count.index}"
    },
    var.tags,
    count.index == 0 ? { "kubernetes.io/role/elb" = "1", "kubernetes.io/cluster/luke-eks" = "owned" } : {},
    count.index == 1 ? { "kubernetes.io/role/internal-elb" = "1", "kubernetes.io/cluster/luke-eks" = "owned" } : {},
  )
}

output "subnet_ids" {
  value = aws_subnet.vpc_subnets[*].id
}

output "public_subnets" {
  value = local.public_subnets
}

output "private_subnets" {
  value = local.private_subnets
}
