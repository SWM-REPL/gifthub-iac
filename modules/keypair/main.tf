resource "tls_private_key" "this" {
  algorithm = "RSA"
  rsa_bits  = var.rsa_bits
}

resource "aws_key_pair" "this" {
  key_name   = var.terraform_name
  public_key = tls_private_key.this.public_key_openssh

  tags = {
    Name = var.terraform_name
  }
}

resource "local_file" "private_key" {
  count    = var.create_private_key_file ? 1 : 0
  content  = tls_private_key.this.private_key_pem
  filename = "${var.private_key_path}/${var.terraform_name}.pem"

  file_permission = "0600"
}
