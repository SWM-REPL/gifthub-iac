variable "ami" {
  description = "Bastion 인스턴스에 사용할 AMI"
  type        = string
  default     = "ami-00e557080ac814181"
}

variable "instance_type" {
  description = "Bastion 인스턴스의 유형"
  type        = string
  default     = "t2.micro"
}

variable "key_name" {
  description = "Bastion 인스턴스에 사용할 키 페어의 이름"
  type        = string
}

variable "subnet_id" {
  description = "Bastion 인스턴스를 시작할 서브넷의 ID"
  type        = string
}

variable "region_name" {
  description = "AWS 리전의 이름"
  type        = string
}

variable "terraform_name" {
  description = "Terraform으로 관리되는 리소스에 사용할 이름"
  type        = string
}

variable "env_name" {
  description = "환경의 이름 (예: dev, staging, prod)"
  type        = string
}

variable "availability_zone" {
  description = "Bastion 인스턴스를 시작할 가용 영역"
  type        = string
}

variable "vpc_id" {
  description = "보안 그룹을 생성할 VPC의 ID"
  type        = string
}

variable "allowed_cidr_blocks" {
  description = "Bastion 호스트에 연결을 허용할 CIDR 블록 목록"
  type        = list(string)
}

variable "ovpn_file_path" {
  description = "OpenVPN 설정 파일을 저장할 경로"
  type        = string
  default     = "/home/ubuntu/client.ovpn"
}
