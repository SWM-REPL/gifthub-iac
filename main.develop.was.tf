resource "ncloud_access_control_group" "develop_was_acg" {
  name   = "${var.zone_name}-${var.terraform_name}-${var.develop_env_name}-was-acg"
  vpc_no = ncloud_vpc.develop_vpc.id
}

resource "ncloud_access_control_group_rule" "develop_was_acg" {
  access_control_group_no = ncloud_access_control_group.develop_was_acg.id

  inbound {
    protocol                       = "TCP"
    source_access_control_group_no = ncloud_access_control_group.develop_bastion_acg.id
    port_range                     = "22"
    description                    = "accept 22 port (only bastion)"
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

resource "ncloud_network_interface" "develop_was_nic" {
  name                  = "${var.terraform_name}-was-nic"
  subnet_no             = ncloud_subnet.develop_app_subnet.id
  access_control_groups = [ncloud_access_control_group.develop_was_acg.id]
}

resource "ncloud_server" "develop_was_server" {
  subnet_no                 = ncloud_subnet.develop_app_subnet.id
  name                      = "${var.zone_name}-${var.terraform_name}-${var.develop_env_name}-was"
  server_image_product_code = "SW.VSVR.OS.LNX64.UBNTU.SVR2004.B050"
  server_product_code       = "SVR.VSVR.STAND.C002.M008.NET.HDD.B050.G002"
  login_key_name            = ncloud_login_key.develop_key.key_name
  network_interface {
    network_interface_no = ncloud_network_interface.develop_was_nic.id
    order                = 0
  }
}

data "ncloud_root_password" "develop_was_root_password" {
  server_instance_no = ncloud_server.develop_was_server.instance_no
  private_key        = ncloud_login_key.develop_key.private_key
}

resource "local_file" "develop_was_root_password_file" {
  filename = "${ncloud_server.develop_was_server.name}-root-password.txt"
  content  = "${ncloud_server.develop_was_server.name} => ${data.ncloud_root_password.develop_was_root_password.root_password}"
}
