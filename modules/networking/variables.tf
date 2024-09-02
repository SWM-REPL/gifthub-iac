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
}

variable "vpc_cidr_block" {
  description = "VPC CIDR"
  type        = string
}

variable "availability_zone1" {
  description = "가용영역1"
  type        = string
  default     = "ap-northeast-2a"
}

variable "availability_zone2" {
  description = "가용영역2"
  type        = string
  default     = "ap-northeast-2b"
}

variable "availability_zone3" {
  description = "가용영역3"
  type        = string
  default     = "ap-northeast-2c"
}
