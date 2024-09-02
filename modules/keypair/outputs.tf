output "key_name" {
  description = "생성된 키 페어의 이름"
  value       = aws_key_pair.this.key_name
}

output "key_pair_id" {
  description = "생성된 키 페어의 ID"
  value       = aws_key_pair.this.id
}

output "public_key" {
  description = "생성된 퍼블릭 키"
  value       = aws_key_pair.this.public_key
}

output "private_key_pem" {
  description = "생성된 프라이빗 키 (PEM 형식)"
  value       = tls_private_key.this.private_key_pem
  sensitive   = true
}
