module "networking" {
  source         = "../../modules/networking"
  vpc_cidr_block = var.vpc_cidr_block
  region_name    = var.region_name
  terraform_name = var.terraform_name
  env_name       = var.env_name
}

module "keypair" {
  source         = "../../modules/keypair"
  terraform_name = var.terraform_name
}

module "bastion_az1" {
  source              = "../../modules/bastion"
  region_name         = var.region_name
  terraform_name      = var.terraform_name
  env_name            = var.env_name
  allowed_cidr_blocks = [var.host_cidr_block]
  vpc_id              = module.networking.vpc_id
  subnet_id           = module.networking.net_subnet1_id
  availability_zone   = "az1"
  key_name            = module.keypair.key_name
}

module "rds" {
  source                 = "../../modules/database"
  region_name            = var.region_name
  terraform_name         = var.terraform_name
  env_name               = var.env_name
  vpc_id                 = module.networking.vpc_id
  subnet_ids             = [module.networking.data_subnet1_id, module.networking.data_subnet2_id, module.networking.data_subnet3_id]
  db_username            = var.db_username
  db_password            = var.db_password
  net_subnet1_cidr_block = module.networking.net_subnet1_cidr_block
}
