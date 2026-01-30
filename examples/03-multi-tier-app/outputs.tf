output "vpc_id" {
  description = "ID of the VPC"
  value       = aws_vpc.main.id
}

output "public_subnet_ids" {
  description = "IDs of the public subnets"
  value       = aws_subnet.public[*].id
}

output "private_subnet_ids" {
  description = "IDs of the private subnets"
  value       = aws_subnet.private[*].id
}

output "alb_dns_name" {
  description = "DNS name of the Application Load Balancer"
  value       = aws_lb.main.dns_name
}

output "alb_url" {
  description = "URL to access the application"
  value       = "http://${aws_lb.main.dns_name}"
}

output "instance_ids" {
  description = "IDs of the web server instances"
  value       = aws_instance.web[*].id
}

output "instance_private_ips" {
  description = "Private IP addresses of the web servers"
  value       = aws_instance.web[*].private_ip
}

output "nat_gateway_ip" {
  description = "Public IP address of the NAT Gateway"
  value       = aws_eip.nat.public_ip
}

output "availability_zones" {
  description = "Availability zones used for deployment"
  value       = slice(data.aws_availability_zones.available.names, 0, 2)
}

output "alb_security_group_id" {
  description = "ID of the ALB security group"
  value       = aws_security_group.alb.id
}

output "web_security_group_id" {
  description = "ID of the web server security group"
  value       = aws_security_group.web.id
}

output "instructions" {
  description = "Instructions for accessing the application"
  value       = <<-EOT
    Application deployed successfully!
    
    Access the application at: http://${aws_lb.main.dns_name}
    
    Note: It may take 2-3 minutes for the instances to become healthy
    and start serving traffic.
    
    To check target health:
    1. Go to AWS Console -> EC2 -> Target Groups
    2. Select "${var.project_name}-tg"
    3. Check the "Targets" tab
    
    When done testing, destroy resources to avoid charges:
    terraform destroy
  EOT
}
