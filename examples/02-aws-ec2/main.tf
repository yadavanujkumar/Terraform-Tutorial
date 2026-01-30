# Configure Terraform and AWS Provider
terraform {
  required_version = ">= 1.0"
  
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = var.aws_region
  
  default_tags {
    tags = {
      Project     = var.project_name
      Environment = var.environment
      ManagedBy   = "Terraform"
    }
  }
}

# Data source to get the latest Amazon Linux 2 AMI
data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]
  
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
  
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

# Create EC2 instance
resource "aws_instance" "web" {
  ami           = data.aws_ami.amazon_linux.id
  instance_type = var.instance_type
  
  # Associate the security group
  vpc_security_group_ids = [aws_security_group.allow_ssh.id]
  
  # Optional: Associate key pair for SSH access
  # Uncomment and set key_name variable if you want SSH access
  # key_name = var.key_name
  
  # User data script to install and start a simple web server
  user_data = <<-EOF
              #!/bin/bash
              yum update -y
              yum install -y httpd
              systemctl start httpd
              systemctl enable httpd
              echo "<h1>Hello from Terraform!</h1><p>Instance ID: $(ec2-metadata --instance-id | cut -d ' ' -f 2)</p>" > /var/www/html/index.html
              EOF
  
  # Tags
  tags = {
    Name = "${var.project_name}-instance"
  }
  
  # Lifecycle settings
  lifecycle {
    create_before_destroy = true
  }
}
