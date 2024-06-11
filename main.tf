
#################
# VPC resources #
#################

# VPC for management

module "vpc" {
  providers = {
    aws = aws.management-admin
  }
  cidr_block = "${var.cidr_prefix["management"]}.0.0/16"
  source     = "./modules/vpc"
}

module "subnets" {
  providers = {
    aws = aws.management-admin
  }
  vpc_id                 = module.vpc.vpc_id
  cidr_prefix            = var.cidr_prefix["management"]
  subnet_cidr_az_mapping = var.subnet_cidr_az_mapping
  source                 = "./modules/subnets"
  depends_on             = [module.vpc]
}

# VPC for sb1

module "vpc_sb1" {
  providers = {
    aws = aws.sb1
  }
  cidr_block = "${var.cidr_prefix["sb1"]}.0.0/16"
  source     = "./modules/vpc"
}

module "subnets_sb1" {
  providers = {
    aws = aws.sb1
  }
  vpc_id                 = module.vpc_sb1.vpc_id
  cidr_prefix            = var.cidr_prefix["sb1"]
  subnet_cidr_az_mapping = var.subnet_cidr_az_mapping
  source                 = "./modules/subnets"

  depends_on = [module.vpc_sb1]
}

# VPC for sb2

module "vpc_sb2" {
  providers = {
    aws = aws.sb2
  }
  cidr_block = "${var.cidr_prefix["sb2"]}.0.0/16"
  source     = "./modules/vpc"
}

module "subnets_sb2" {
  providers = {
    aws = aws.sb2
  }
  vpc_id                 = module.vpc_sb2.vpc_id
  cidr_prefix            = var.cidr_prefix["sb2"]
  subnet_cidr_az_mapping = var.subnet_cidr_az_mapping
  source                 = "./modules/subnets"

  depends_on = [module.vpc_sb2]
}
