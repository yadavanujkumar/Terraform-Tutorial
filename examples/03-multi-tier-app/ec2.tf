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

# User data script for web servers
locals {
  user_data = <<-EOF
              #!/bin/bash
              yum update -y
              yum install -y httpd
              systemctl start httpd
              systemctl enable httpd
              
              # Get instance metadata
              INSTANCE_ID=$(ec2-metadata --instance-id | cut -d ' ' -f 2)
              AVAILABILITY_ZONE=$(ec2-metadata --availability-zone | cut -d ' ' -f 2)
              
              # Create a simple web page
              cat > /var/www/html/index.html <<HTML
              <!DOCTYPE html>
              <html>
              <head>
                  <title>Terraform Multi-Tier App</title>
                  <style>
                      body {
                          font-family: Arial, sans-serif;
                          max-width: 800px;
                          margin: 50px auto;
                          padding: 20px;
                          background-color: #f0f0f0;
                      }
                      .container {
                          background-color: white;
                          padding: 30px;
                          border-radius: 10px;
                          box-shadow: 0 2px 5px rgba(0,0,0,0.1);
                      }
                      h1 { color: #FF9900; }
                      .info { 
                          background-color: #f9f9f9;
                          padding: 15px;
                          border-left: 4px solid #FF9900;
                          margin: 20px 0;
                      }
                  </style>
              </head>
              <body>
                  <div class="container">
                      <h1>🚀 Hello from Terraform!</h1>
                      <p>This is a multi-tier web application deployed on AWS using Terraform.</p>
                      <div class="info">
                          <strong>Instance Information:</strong><br>
                          Instance ID: $INSTANCE_ID<br>
                          Availability Zone: $AVAILABILITY_ZONE<br>
                          Server Time: $(date)
                      </div>
                      <p>This server is running in a private subnet and is accessible through an Application Load Balancer.</p>
                  </div>
              </body>
              </html>
              HTML
              EOF
}

# Create EC2 instances in private subnets
resource "aws_instance" "web" {
  count                  = var.instance_count
  ami                    = data.aws_ami.amazon_linux.id
  instance_type          = var.instance_type
  subnet_id              = aws_subnet.private[count.index % 2].id
  vpc_security_group_ids = [aws_security_group.web.id]
  
  user_data = local.user_data
  
  tags = {
    Name = "${var.project_name}-web-${count.index + 1}"
  }
  
  lifecycle {
    create_before_destroy = true
  }
}
