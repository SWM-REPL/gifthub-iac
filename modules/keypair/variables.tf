variable "terraform_name" {
  description = "생성할 키 페어의 이름"
  type        = string
}

variable "rsa_bits" {
  description = "RSA 키의 비트 수"
  type        = number
  default     = 2048
}

variable "create_private_key_file" {
  description = "프라이빗 키 파일을 로컬에 생성할지 여부"
  type        = bool
  default     = true
}

variable "private_key_path" {
  description = "프라이빗 키 파일을 저장할 경로"
  type        = string
  default     = "."
}
