resource "aws_internet_gateway" "igw_sb1" {
  provider = aws.sb1
  vpc_id   = module.vpc_sb1.vpc_id
}
