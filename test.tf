provider "aws" {
  region = "us-east-1"
}

locals {
  cidr_block = "10.0.0.0/16"
}
module "create_vpc" {
  source                     = "./modules/vpc"
  name                       = "test_vpc"
  availability_zones         = ["us-east-1a", "us-east-1b", "us-east-1c"]
  vpc_cidr_block             = local.cidr_block
  public_subnet_cidr_blocks  = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  private_subnet_cidr_blocks = ["10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]

  # create_eip = true   # If want a EIP for NAT
  # create_nat = true   # If want a NAT
}

# module "create_s3" {
#   source      = "./modules/s3"
#   bucket_name = "test-bucket-816"
#   ############## Enable for public acces ##############
#   # acl = "public-read"
#   # block_public_acls = false
#   # block_public_policy = false
#   # ignore_public_acls = false
#   # restrict_public_buckets = false
# }

module "creae_rds" {
  source         = "./modules/rds"
  name           = "test-rds"
  db_name        = "tedtdb"
  engine         = "mysql"
  engine_version = "8.0"
  instance_class = "db.t3a.micro"
  username       = "admin"
  password       = "password@123"
  vpc_id         = module.create_vpc.vpc_id
  subnet_ids     = module.create_vpc.private_subnet_ids
  sg_cidr_blocks = local.cidr_block

  depends_on = [module.create_vpc]
}

# output "pr_subnet_ids" {
#   value = module.create_vpc.private_subnet_ids
# }