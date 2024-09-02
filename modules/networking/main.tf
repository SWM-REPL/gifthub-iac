# VPC 리소스
resource "aws_vpc" "vpc" {
  cidr_block           = var.vpc_cidr_block
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "${var.region_name}-${var.terraform_name}-${var.env_name}-vpc"
  }
}

# Internet Gateway 리소스
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "${var.region_name}-${var.terraform_name}-${var.env_name}-igw"
  }
}

# net 서브넷 리소스
resource "aws_subnet" "net_subnet1" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = cidrsubnet(var.vpc_cidr_block, 8, 0)
  availability_zone = var.availability_zone1

  tags = {
    Name = "${var.region_name}-${var.terraform_name}-${var.env_name}-net/az1"
  }
}

resource "aws_subnet" "net_subnet2" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = cidrsubnet(var.vpc_cidr_block, 8, 1)
  availability_zone = var.availability_zone2

  tags = {
    Name = "${var.region_name}-${var.terraform_name}-${var.env_name}-net/az2"
  }
}

resource "aws_subnet" "net_subnet3" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = cidrsubnet(var.vpc_cidr_block, 8, 2)
  availability_zone = var.availability_zone3

  tags = {
    Name = "${var.region_name}-${var.terraform_name}-${var.env_name}-net/az3"
  }
}

# app 서브넷 리소스
resource "aws_subnet" "app_subnet1" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = cidrsubnet(var.vpc_cidr_block, 8, 3)
  availability_zone = var.availability_zone1

  tags = {
    Name = "${var.region_name}-${var.terraform_name}-${var.env_name}-app/az1"
  }
}

resource "aws_subnet" "app_subnet2" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = cidrsubnet(var.vpc_cidr_block, 8, 4)
  availability_zone = var.availability_zone2

  tags = {
    Name = "${var.region_name}-${var.terraform_name}-${var.env_name}-app/az2"
  }
}

resource "aws_subnet" "app_subnet3" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = cidrsubnet(var.vpc_cidr_block, 8, 5)
  availability_zone = var.availability_zone3

  tags = {
    Name = "${var.region_name}-${var.terraform_name}-${var.env_name}-app/az3"
  }
}

# data 서브넷 리소스
resource "aws_subnet" "data_subnet1" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = cidrsubnet(var.vpc_cidr_block, 8, 6)
  availability_zone = var.availability_zone1

  tags = {
    Name = "${var.region_name}-${var.terraform_name}-${var.env_name}-data/az1"
  }
}

resource "aws_subnet" "data_subnet2" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = cidrsubnet(var.vpc_cidr_block, 8, 7)
  availability_zone = var.availability_zone2

  tags = {
    Name = "${var.region_name}-${var.terraform_name}-${var.env_name}-data/az2"
  }
}

resource "aws_subnet" "data_subnet3" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = cidrsubnet(var.vpc_cidr_block, 8, 8)
  availability_zone = var.availability_zone3

  tags = {
    Name = "${var.region_name}-${var.terraform_name}-${var.env_name}-data/az3"
  }
}

# NAT Gateway 할당을 위한 Elastic IP 리소스
resource "aws_eip" "ngw_eip" {
  domain = "vpc"
}

# NAT Gateway 리소스
resource "aws_nat_gateway" "ngw" {
  allocation_id = aws_eip.ngw_eip.id
  subnet_id     = aws_subnet.net_subnet1.id

  tags = {
    Name = "${var.region_name}-${var.terraform_name}-${var.env_name}-ngw"
  }
}

# net 서브넷 라우팅 테이블 리소스
resource "aws_route_table" "net_route_table" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "${var.region_name}-${var.terraform_name}-${var.env_name}-net-rtb"
  }

  depends_on = [
    aws_internet_gateway.igw
  ]
}

resource "aws_route_table_association" "net_subnet1" {
  subnet_id      = aws_subnet.net_subnet1.id
  route_table_id = aws_route_table.net_route_table.id
}

resource "aws_route_table_association" "net_subnet2" {
  subnet_id      = aws_subnet.net_subnet2.id
  route_table_id = aws_route_table.net_route_table.id
}

resource "aws_route_table_association" "net_subnet3" {
  subnet_id      = aws_subnet.net_subnet3.id
  route_table_id = aws_route_table.net_route_table.id
}

# app 서브넷 라우팅 테이블 리소스
resource "aws_route_table" "app_route_table" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "${var.region_name}-${var.terraform_name}-${var.env_name}-app-rtb"
  }
}

resource "aws_route_table_association" "app_subnet1" {
  subnet_id      = aws_subnet.app_subnet1.id
  route_table_id = aws_route_table.app_route_table.id
}

resource "aws_route_table_association" "app_subnet2" {
  subnet_id      = aws_subnet.app_subnet2.id
  route_table_id = aws_route_table.app_route_table.id
}

resource "aws_route_table_association" "app_subnet3" {
  subnet_id      = aws_subnet.app_subnet3.id
  route_table_id = aws_route_table.app_route_table.id
}

resource "aws_route" "outbound_nat_route" {
  route_table_id         = aws_route_table.app_route_table.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.ngw.id
}

# data 서브넷 라우팅 테이블 리소스
resource "aws_route_table" "data_route_table" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "${var.region_name}-${var.terraform_name}-${var.env_name}-data-rtb"
  }
}

resource "aws_route_table_association" "data_subnet1" {
  subnet_id      = aws_subnet.data_subnet1.id
  route_table_id = aws_route_table.data_route_table.id
}

resource "aws_route_table_association" "data_subnet2" {
  subnet_id      = aws_subnet.data_subnet2.id
  route_table_id = aws_route_table.data_route_table.id
}

resource "aws_route_table_association" "data_subnet3" {
  subnet_id      = aws_subnet.data_subnet3.id
  route_table_id = aws_route_table.data_route_table.id
}

resource "aws_route" "data_to_app" {
  route_table_id         = aws_route_table.data_route_table.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.ngw.id
}
