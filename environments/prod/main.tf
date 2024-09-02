module "networking" {
  source         = "../../modules/networking"
  vpc_cidr_block = var.vpc_cidr_block
  region_name    = var.region_name
  terraform_name = var.terraform_name
  env_name       = var.env_name
}
