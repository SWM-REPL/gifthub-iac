resource "aws_eip" "bastion" {
  tags = {
    Name = "${var.region_name}-${var.terraform_name}-${var.env_name}-bastion-eip"
  }
}

resource "aws_instance" "bastion" {
  ami           = var.ami
  instance_type = var.instance_type
  key_name      = var.key_name
  subnet_id     = var.subnet_id

  vpc_security_group_ids = [aws_security_group.bastion_sg.id]

  tags = {
    Name = "${var.region_name}-${var.terraform_name}-${var.env_name}-bastion/${var.availability_zone}"
  }
}

resource "aws_eip_association" "bastion" {
  instance_id   = aws_instance.bastion.id
  allocation_id = aws_eip.bastion.id
}

resource "aws_security_group" "bastion_sg" {
  name        = "${var.region_name}-${var.terraform_name}-${var.env_name}-bastion-sg"
  description = "Security group for bastion host"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = var.allowed_cidr_blocks
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.region_name}-${var.terraform_name}-${var.env_name}-bastion-sg"
  }
}
