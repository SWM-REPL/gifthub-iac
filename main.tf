/*
** 개발 환경
*/
resource "ncloud_vpc" "vpc" {
  name            = "${var.zone_name}-${var.terraform_name}-${var.develop_env_name}-vpc"
  ipv4_cidr_block = var.vpc_develop_cidr
}

/*
** 운영 환경
*/
