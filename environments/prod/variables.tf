variable "vpc_cidr_block" {
  description = "VPC CIDR"
  type        = string
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

variable "env_name" {
  description = "환경명"
  type        = string
  default     = "prod"
}

variable "host_cidr_block" {
  description = "Bastion 호스트에 연결을 허용할 CIDR 블록"
  type        = string
}
