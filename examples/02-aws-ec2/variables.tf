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
    condition     = can(regex("^t[2-3]\\.(micro|small|medium)$", var.instance_type))
    error_message = "Instance type must be a t2 or t3 instance (micro, small, or medium)."
  }
}

variable "allowed_ssh_cidr" {
  description = "CIDR blocks allowed to SSH into the instance"
  type        = list(string)
  default     = ["0.0.0.0/0"]  # WARNING: Open to all IPs. Restrict in production!
}

# Uncomment if you want to use an existing key pair for SSH access
# variable "key_name" {
#   description = "Name of the AWS key pair for SSH access"
#   type        = string
#   default     = ""
# }
