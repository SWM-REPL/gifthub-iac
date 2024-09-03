variable "region_name" {
  type = string
}

variable "terraform_name" {
  type = string
}

variable "env_name" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "db_engine" {
  description = "데이터베이스 엔진"
  type        = string
  default     = "mysql"
}

variable "db_engine_version" {
  description = "데이터베이스 엔진 버전"
  type        = string
  default     = "8.0"
}

variable "db_instance_class" {
  description = "데이터베이스 인스턴스 클래스"
  type        = string
  default     = "db.t3.micro"
}

variable "allocated_storage" {
  description = "할당된 스토리지 크기"
  type        = number
  default     = 20
}

variable "max_allocated_storage" {
  description = "최대 할당 스토리지 크기"
  type        = number
  default     = 100
}

variable "storage_type" {
  description = "스토리지 타입"
  type        = string
  default     = "gp2"
}

variable "db_username" {
  description = "데이터베이스 사용자 이름"
  type        = string
}

variable "db_password" {
  description = "데이터베이스 사용자 비밀번호"
  type        = string
}

variable "subnet_ids" {
  description = "데이터베이스 서브넷 그룹을 위한 서브넷 ID 목록"
  type        = list(string)
}

variable "db_parameter_group_family" {
  description = "데이터베이스 파라미터 그룹 패밀리"
  type        = string
  default     = "mysql8.0"
}
