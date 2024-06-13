terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.66.0"
    }
  }
}

resource "aws_eip" "nat_gw" {
  count = length(var.public_subnet_ids)
}

resource "aws_nat_gateway" "nat_gw" {
  count         = length(var.public_subnet_ids)
  allocation_id = aws_eip.nat_gw[count.index].id
  subnet_id     = var.public_subnet_ids[count.index]
}

output "nat_gw_id" {
  value = aws_nat_gateway.nat_gw[*].id
}
