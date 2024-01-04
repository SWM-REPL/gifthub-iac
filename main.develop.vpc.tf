// VPC
resource "ncloud_vpc" "develop_vpc" {
  name            = "${var.zone_name}-${var.terraform_name}-${var.develop_env_name}-vpc"
  ipv4_cidr_block = var.vpc_develop_cidr


}

// NACL - PUBLIC
resource "ncloud_network_acl" "develop_public_acl" {
  name   = "${var.zone_name}-${var.terraform_name}-${var.develop_env_name}-net-public"
  vpc_no = ncloud_vpc.develop_vpc.id
}

// NACL - PRIVATE
resource "ncloud_network_acl" "develop_private_acl" {
  name   = "${var.zone_name}-${var.terraform_name}-${var.develop_env_name}-net-private"
  vpc_no = ncloud_vpc.develop_vpc.id
}

// Subnet - net (bastion)
resource "ncloud_subnet" "develop_net_subnet" {
  name           = "${var.zone_name}-${var.terraform_name}-${var.develop_env_name}-net-public"
  vpc_no         = ncloud_vpc.develop_vpc.id
  subnet         = cidrsubnet(ncloud_vpc.develop_vpc.ipv4_cidr_block, 8, 0)
  zone           = var.zones
  network_acl_no = ncloud_network_acl.develop_public_acl.id
  subnet_type    = "PUBLIC"
}

// Subnet - app (was, web)
resource "ncloud_subnet" "develop_app_subnet" {
  name           = "${var.zone_name}-${var.terraform_name}-${var.develop_env_name}-app-private"
  vpc_no         = ncloud_vpc.develop_vpc.id
  subnet         = cidrsubnet(ncloud_vpc.develop_vpc.ipv4_cidr_block, 8, 1)
  zone           = var.zones
  network_acl_no = ncloud_network_acl.develop_private_acl.id
  subnet_type    = "PRIVATE"
}

// Subnet - data (rds, opensearch)
resource "ncloud_subnet" "develop_data_subnet" {
  name           = "${var.zone_name}-${var.terraform_name}-${var.develop_env_name}-data-private"
  vpc_no         = ncloud_vpc.develop_vpc.id
  subnet         = cidrsubnet(ncloud_vpc.develop_vpc.ipv4_cidr_block, 8, 2)
  zone           = var.zones
  network_acl_no = ncloud_network_acl.develop_private_acl.id
  subnet_type    = "PRIVATE"
}
