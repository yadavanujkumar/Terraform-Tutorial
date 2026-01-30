# Terraform Tutorial 🚀

A comprehensive guide to learning Terraform from basics to building real-world infrastructure.

## 📚 Table of Contents

- [What is Terraform?](#what-is-terraform)
- [Key Features](#key-features)
- [Prerequisites](#prerequisites)
- [Installation](#installation)
- [Quick Start](#quick-start)
- [Basic Concepts](#basic-concepts)
- [Mini Projects](#mini-projects)
- [Best Practices](#best-practices)
- [Troubleshooting](#troubleshooting)
- [Additional Resources](#additional-resources)

## What is Terraform?

**Terraform** is an open-source Infrastructure as Code (IaC) tool created by HashiCorp. It allows you to define and provision infrastructure using a declarative configuration language called **HCL (HashiCorp Configuration Language)**.

### Why Terraform?

- **Infrastructure as Code**: Manage infrastructure using code instead of manual processes
- **Cloud Agnostic**: Works with multiple cloud providers (AWS, Azure, GCP, etc.)
- **Version Control**: Track infrastructure changes using Git
- **Automation**: Automate infrastructure provisioning and management
- **Consistency**: Ensure consistent infrastructure across environments
- **Cost Management**: Preview changes before applying them

## Key Features

### 1. **Declarative Configuration**
You describe *what* you want, not *how* to create it.

### 2. **Execution Plans**
Preview changes before applying them with `terraform plan`.

### 3. **Resource Graph**
Terraform builds a dependency graph and creates/modifies resources in parallel when possible.

### 4. **State Management**
Tracks the current state of your infrastructure to determine what changes need to be made.

### 5. **Provider Ecosystem**
Support for 1000+ providers including AWS, Azure, GCP, Kubernetes, and more.

## Prerequisites

Before starting with Terraform, you should have:

- Basic understanding of cloud computing concepts
- Familiarity with command-line interfaces
- An account with a cloud provider (AWS, Azure, or GCP)
- Text editor or IDE (VS Code recommended)

## Installation

### macOS
```bash
brew tap hashicorp/tap
brew install hashicorp/tap/terraform
```

### Linux (Ubuntu/Debian)
```bash
wget -O- https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
sudo apt update && sudo apt install terraform
```

### Windows
Download the binary from [Terraform Downloads](https://www.terraform.io/downloads.html) and add to PATH.

### Verify Installation
```bash
terraform version
```

## Quick Start

Here's a simple example to create a file on your local system:

### 1. Create a directory for your project
```bash
mkdir terraform-quickstart
cd terraform-quickstart
```

### 2. Create a Terraform configuration file (`main.tf`)
```hcl
# main.tf
terraform {
  required_version = ">= 1.0"
}

resource "local_file" "hello" {
  content  = "Hello, Terraform!"
  filename = "${path.module}/hello.txt"
}

output "file_path" {
  value = local_file.hello.filename
}
```

### 3. Initialize Terraform
```bash
terraform init
```

This downloads the necessary provider plugins.

### 4. Preview changes
```bash
terraform plan
```

This shows what Terraform will do without making actual changes.

### 5. Apply changes
```bash
terraform apply
```

Type `yes` when prompted. This creates the `hello.txt` file.

### 6. Verify the output
```bash
cat hello.txt
```

### 7. Destroy resources
```bash
terraform destroy
```

Type `yes` to remove the created file.

## Basic Concepts

### 1. **Providers**
Providers are plugins that interact with cloud platforms and services.

```hcl
provider "aws" {
  region = "us-east-1"
}
```

### 2. **Resources**
Resources are the building blocks of infrastructure (e.g., EC2 instances, S3 buckets).

```hcl
resource "aws_instance" "web" {
  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = "t2.micro"
}
```

### 3. **Variables**
Variables allow you to parameterize your configurations.

```hcl
variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro"
}
```

### 4. **Outputs**
Outputs display information after applying configurations.

```hcl
output "instance_ip" {
  value = aws_instance.web.public_ip
}
```

### 5. **State**
Terraform stores the state of your infrastructure in `terraform.tfstate`. This is crucial for tracking resources.

## Mini Projects

This repository includes several hands-on mini projects:

### Project 1: [Simple Local File Management](./examples/01-local-file/)
Learn Terraform basics by managing local files.

### Project 2: [AWS EC2 Instance](./examples/02-aws-ec2/)
Deploy a simple EC2 instance on AWS.

### Project 3: [Multi-Tier Web Application](./examples/03-multi-tier-app/)
Build a complete VPC with subnets, security groups, and EC2 instances.

Each project includes:
- Complete Terraform configuration files
- Step-by-step README
- Explanation of concepts used

## Best Practices

1. **Use Version Control**: Always commit your Terraform configurations to Git
2. **Use Remote State**: Store state files remotely (e.g., S3, Terraform Cloud)
3. **Lock State Files**: Prevent concurrent modifications using state locking
4. **Use Variables**: Avoid hardcoding values
5. **Organize Code**: Split configurations into multiple files (main.tf, variables.tf, outputs.tf)
6. **Use Modules**: Create reusable infrastructure components
7. **Plan Before Apply**: Always run `terraform plan` before `terraform apply`
8. **Use Workspaces**: Manage multiple environments (dev, staging, prod)
9. **Secure Sensitive Data**: Use Terraform Vault or AWS Secrets Manager
10. **Document Your Code**: Add comments and README files

## Terraform Workflow

```
┌─────────────┐
│   Write     │  Create .tf files
└──────┬──────┘
       │
       ▼
┌─────────────┐
│    Init     │  terraform init
└──────┬──────┘
       │
       ▼
┌─────────────┐
│    Plan     │  terraform plan
└──────┬──────┘
       │
       ▼
┌─────────────┐
│   Apply     │  terraform apply
└──────┬──────┘
       │
       ▼
┌─────────────┐
│  Destroy    │  terraform destroy (when needed)
└─────────────┘
```

## Common Commands

| Command | Description |
|---------|-------------|
| `terraform init` | Initialize a Terraform working directory |
| `terraform plan` | Preview changes before applying |
| `terraform apply` | Create or update infrastructure |
| `terraform destroy` | Destroy managed infrastructure |
| `terraform fmt` | Format configuration files |
| `terraform validate` | Validate configuration files |
| `terraform show` | Display current state |
| `terraform output` | Display output values |
| `terraform state list` | List resources in state |
| `terraform refresh` | Update state with real infrastructure |

## Troubleshooting

### Issue: "Error: Failed to get existing workspaces"
**Solution**: Initialize the backend with `terraform init -reconfigure`

### Issue: "Error: Resource already exists"
**Solution**: Import existing resources with `terraform import`

### Issue: "Error: State lock"
**Solution**: Use `terraform force-unlock <LOCK_ID>` (use with caution)

### Issue: "Provider version conflicts"
**Solution**: Specify provider version constraints in your configuration

```hcl
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}
```

## Additional Resources

- [Official Terraform Documentation](https://www.terraform.io/docs)
- [Terraform Registry](https://registry.terraform.io/) - Browse providers and modules
- [HashiCorp Learn](https://learn.hashicorp.com/terraform) - Official tutorials
- [Terraform Best Practices](https://www.terraform-best-practices.com/)
- [Awesome Terraform](https://github.com/shuaibiyy/awesome-terraform) - Curated list of resources

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

**Happy Terraforming! 🌍**