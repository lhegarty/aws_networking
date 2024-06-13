resource "aws_route_table" "private_sb1" {
  count    = length(module.nat_gw_sb1.nat_gw_id)
  provider = aws.sb1
  vpc_id   = module.vpc_sb1.vpc_id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = module.nat_gw_sb1.nat_gw_id[count.index]
  }

  tags = {
    Name = "private-route-table-${count.index}"
  }
}

resource "aws_route_table_association" "private_sb1" {
  count          = length(aws_route_table.private_sb1)
  provider       = aws.sb1
  subnet_id      = module.subnets_sb1.private_subnets[count.index]
  route_table_id = aws_route_table.private_sb1[count.index].id
}

resource "aws_route_table" "public_sb1" {
  count    = length(module.subnets_sb1.public_subnets)
  provider = aws.sb1
  vpc_id   = module.vpc_sb1.vpc_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw_sb1.id
  }
  tags = {
    Name = "public-route-table-${count.index}"
  }
}

resource "aws_route_table_association" "public_sb1" {
  count          = length(aws_route_table.public_sb1)
  provider       = aws.sb1
  subnet_id      = module.subnets_sb1.public_subnets[count.index]
  route_table_id = aws_route_table.public_sb1[count.index].id
}

