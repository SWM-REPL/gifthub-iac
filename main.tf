# AWS를 Provider로 설정
provider "aws" {
  access_key = var.access_key
  secret_key = var.secret_key
  region     = var.region
}

# 운영 환경 리소스 생성
module "prod" {
  source          = "./environments/prod"
  vpc_cidr_block  = var.prod_vpc_cidr_block
  region_name     = var.region_name
  terraform_name  = var.terraform_name
  host_cidr_block = var.host_cidr_block
  db_username     = var.db_username
  db_password     = var.db_password
}
