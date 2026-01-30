output "instance_id" {
  description = "ID of the EC2 instance"
  value       = aws_instance.web.id
}

output "instance_public_ip" {
  description = "Public IP address of the EC2 instance"
  value       = aws_instance.web.public_ip
}

output "instance_public_dns" {
  description = "Public DNS name of the EC2 instance"
  value       = aws_instance.web.public_dns
}

output "instance_state" {
  description = "State of the EC2 instance"
  value       = aws_instance.web.instance_state
}

output "security_group_id" {
  description = "ID of the security group"
  value       = aws_security_group.allow_ssh.id
}

output "ami_id" {
  description = "AMI ID used for the instance"
  value       = data.aws_ami.amazon_linux.id
}

output "web_url" {
  description = "URL to access the web server"
  value       = "http://${aws_instance.web.public_ip}"
}

output "ssh_command" {
  description = "SSH command template to connect to the instance (requires key pair configuration)"
  value       = "ssh -i /path/to/your-key.pem ec2-user@${aws_instance.web.public_ip} # Note: Requires key_name to be configured in main.tf"
}
