/*
** 개발 환경
*/

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

// Server - key (develop)
resource "ncloud_login_key" "develop_key" {
  key_name = "${var.terraform_name}-${var.develop_env_name}-key"
}

// Server - .pem file (develop)
resource "local_file" "develop_pem" {
  filename = "${ncloud_login_key.develop_key.key_name}.pem"
  content  = ncloud_login_key.develop_key.private_key
}

// Server - bastion-acg (develop)
resource "ncloud_access_control_group" "develop_bastion_acg" {
  name   = "${var.zone_name}-${var.terraform_name}-${var.develop_env_name}-bastion-acg"
  vpc_no = ncloud_vpc.develop_vpc.id
}

// Server - bastion-acg's rule (develop)
resource "ncloud_access_control_group_rule" "develop_bastion_acg" {
  access_control_group_no = ncloud_access_control_group.develop_bastion_acg.id

  inbound {
    protocol    = "TCP"
    ip_block    = "0.0.0.0/0"
    port_range  = "22"
    description = "accept 22 port(all ip)"
  }
  inbound {
    protocol    = "UDP"
    ip_block    = "0.0.0.0/0"
    port_range  = "1194"
    description = "accept 1194 port(all ip)"
  }
  outbound {
    protocol    = "TCP"
    ip_block    = "0.0.0.0/0"
    port_range  = "1-65535"
    description = "accept TCP 1-65535 port"
  }
  outbound {
    protocol    = "UDP"
    ip_block    = "0.0.0.0/0"
    port_range  = "1-65535"
    description = "accept UDP 1-65535 port"
  }
  outbound {
    protocol    = "ICMP"
    ip_block    = "0.0.0.0/0"
    description = "accept ICMP"
  }
}

// Server - bastion's nic
resource "ncloud_network_interface" "develop_bastion_nic" {
  name                  = "${var.terraform_name}-nic"
  subnet_no             = ncloud_subnet.develop_net_subnet.id
  access_control_groups = [ncloud_access_control_group.develop_bastion_acg.id]
}

// Server - bastion instance
resource "ncloud_server" "develop_bastion_server" {
  subnet_no                 = ncloud_subnet.develop_net_subnet.id
  name                      = "${var.zone_name}-${var.terraform_name}-${var.develop_env_name}-bastion"
  server_image_product_code = "SW.VSVR.OS.LNX64.UBNTU.SVR2004.B050"
  server_product_code       = "SVR.VSVR.STAND.C002.M008.NET.HDD.B050.G002"
  login_key_name            = ncloud_login_key.develop_key.key_name
  network_interface {
    network_interface_no = ncloud_network_interface.develop_bastion_nic.id
    order                = 0
  }
}

// Server - bastion's root password
data "ncloud_root_password" "develop_bastion_root_password" {
  server_instance_no = ncloud_server.develop_bastion_server.instance_no
  private_key        = ncloud_login_key.develop_key.private_key
}

// Sever - bastion's root-password.txt file
resource "local_file" "develop_bastion_root_password_file" {
  filename = "${ncloud_server.develop_bastion_server.name}-root-password.txt"
  content  = "${ncloud_server.develop_bastion_server.name} => ${data.ncloud_root_password.develop_bastion_root_password.root_password}"
}

resource "ncloud_public_ip" "develop_bastion_ip" {
  server_instance_no = ncloud_server.develop_bastion_server.id
  description        = "for ${ncloud_server.develop_bastion_server.name} public ip"
}

/*
** 운영 환경
*/
