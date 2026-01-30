variable "aws_region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = "us-east-1"
}

variable "project_name" {
  description = "Name of the project (used for tagging)"
  type        = string
  default     = "terraform-demo"
}

variable "environment" {
  description = "Environment name"
  type        = string
  default     = "dev"
  
  validation {
    condition     = contains(["dev", "staging", "prod"], var.environment)
    error_message = "Environment must be dev, staging, or prod."
  }
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro"
  
  validation {
    condition     = can(regex("^t[2-4][g]?\\.(micro|small|medium)$", var.instance_type))
    error_message = "Instance type must be a t2, t3, or t4g instance (micro, small, or medium)."
  }
}

variable "allowed_ssh_cidr" {
  description = "CIDR blocks allowed to SSH into the instance. SECURITY WARNING: Default allows access from anywhere. Restrict to your IP in production!"
  type        = list(string)
  default     = ["0.0.0.0/0"]  # WARNING: Open to all IPs. Change to your IP address (e.g., ["YOUR_IP/32"])
}

# Uncomment if you want to use an existing key pair for SSH access
# variable "key_name" {
#   description = "Name of the AWS key pair for SSH access"
#   type        = string
#   default     = ""
# }
