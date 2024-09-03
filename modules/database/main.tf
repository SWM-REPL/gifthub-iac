resource "aws_db_instance" "rds" {
  identifier        = "${var.region_name}-${var.terraform_name}-${var.env_name}-rds"
  engine            = var.db_engine
  engine_version    = var.db_engine_version
  instance_class    = var.db_instance_class
  allocated_storage = var.allocated_storage
  storage_type      = var.storage_type

  username = var.db_username
  password = var.db_password

  multi_az               = false
  vpc_security_group_ids = [aws_security_group.db_sg.id]

  db_subnet_group_name = aws_db_subnet_group.rds_subnet_group.name
  parameter_group_name = aws_db_parameter_group.rds_parameter_group.name

  skip_final_snapshot = true
  publicly_accessible = true

  tags = {
    Name = "${var.region_name}-${var.terraform_name}-${var.env_name}-rds"
  }
}

resource "aws_db_subnet_group" "rds_subnet_group" {
  name       = "${var.region_name}-${var.terraform_name}-${var.env_name}-rds-subnet-group"
  subnet_ids = var.subnet_ids

  tags = {
    Name = "${var.region_name}-${var.terraform_name}-${var.env_name}-rds-subnet-group"
  }
}

resource "aws_db_parameter_group" "rds_parameter_group" {
  family = var.db_parameter_group_family
  name   = "${var.region_name}-${var.terraform_name}-${var.env_name}-rds-parameter-group"

  parameter {
    name  = "character_set_server"
    value = "utf8"
  }

  parameter {
    name  = "character_set_client"
    value = "utf8"
  }
}

resource "aws_security_group" "db_sg" {
  vpc_id = var.vpc_id

  ingress {
    from_port = 3306 # MySQL/Aurora default port
    to_port   = 3306
    protocol  = "tcp"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.region_name}-${var.terraform_name}-${var.env_name}-rds-sg"
  }
}
