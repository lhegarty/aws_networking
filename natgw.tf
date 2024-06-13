module "nat_gw_sb1" {
  providers = {
    aws = aws.sb1
  }
  public_subnet_ids = module.subnets_sb1.public_subnets
  source            = "./modules/natgw"
}
