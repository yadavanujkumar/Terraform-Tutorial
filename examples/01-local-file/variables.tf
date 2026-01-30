variable "project_name" {
  description = "Name of the project"
  type        = string
  default     = "terraform-local-file-demo"
}

variable "environment" {
  description = "Environment name (dev, staging, prod)"
  type        = string
  default     = "dev"
  
  validation {
    condition     = contains(["dev", "staging", "prod"], var.environment)
    error_message = "Environment must be dev, staging, or prod."
  }
}

variable "welcome_message" {
  description = "Welcome message to be written to the file"
  type        = string
  default     = "Welcome to Terraform! This file was created by Infrastructure as Code."
}
