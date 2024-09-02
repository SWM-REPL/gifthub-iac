output "docker_compose_command" {
  description = "Command to manage the OpenVPN container using Docker Compose"
  value       = "ssh -i <your-key.pem> ubuntu@${aws_instance.bastion.public_ip} 'cd /home/ubuntu && sudo docker-compose [command]'"
}
