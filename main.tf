# AWS를 Provider로 설정
provider "aws" {
  access_key = var.access_key
  secret_key = var.secret_key
  region     = var.region
}
