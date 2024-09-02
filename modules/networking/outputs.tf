output "vpc_id" {
  value = aws_vpc.vpc.id
}

output "net_subnet1_id" {
  value = aws_subnet.net_subnet1.id
}

output "net_subnet2_id" {
  value = aws_subnet.net_subnet2.id
}

output "net_subnet3_id" {
  value = aws_subnet.net_subnet3.id
}

output "app_subnet1_id" {
  value = aws_subnet.app_subnet1.id
}

output "app_subnet2_id" {
  value = aws_subnet.app_subnet2.id
}

output "app_subnet3_id" {
  value = aws_subnet.app_subnet3.id
}

output "data_subnet1_id" {
  value = aws_subnet.data_subnet1.id
}

output "data_subnet2_id" {
  value = aws_subnet.data_subnet2.id
}

output "data_subnet3_id" {
  value = aws_subnet.data_subnet3.id
}
