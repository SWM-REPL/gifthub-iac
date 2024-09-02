variable "access_key" {
  description = "AWS accesskey"
  type        = string
}

variable "secret_key" {
  description = "AWS accesskey"
  type        = string
}

variable "region" {
  description = "AWS region"
  default     = "ap-northeast-2"
}

variable "region_name" {
  description = "리전명"
  type        = string
  default     = "apne2"
}

variable "terraform_name" {
  description = "서비스명"
  type        = string
}

variable "prod_vpc_cidr_block" {
  description = "Production Environment VPC CIDR"
  type        = string
}

variable "key_name" {
  description = "EC2 인스턴스에 사용할 키 페어의 이름"
  type        = string
}

variable "host_cidr_block" {
  description = "Bastion 호스트에 연결을 허용할 CIDR 블록"
}
