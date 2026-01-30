# Terraform Cheat Sheet

Quick reference guide for Terraform commands and syntax.

## Essential Commands

### Initialization and Setup
```bash
terraform init              # Initialize working directory
terraform init -upgrade     # Upgrade provider plugins
terraform init -reconfigure # Reconfigure backend
```

### Planning and Applying
```bash
terraform plan                    # Preview changes
terraform plan -out=tfplan        # Save plan to file
terraform apply                   # Apply changes (interactive)
terraform apply -auto-approve     # Apply without confirmation
terraform apply tfplan            # Apply saved plan
terraform apply -target=resource  # Apply specific resource
```

### Destroying
```bash
terraform destroy                    # Destroy all resources
terraform destroy -auto-approve      # Destroy without confirmation
terraform destroy -target=resource   # Destroy specific resource
```

### State Management
```bash
terraform show                      # Show current state
terraform state list                # List resources in state
terraform state show <resource>     # Show specific resource
terraform state rm <resource>       # Remove resource from state
terraform state mv <src> <dest>     # Move/rename resource
terraform state pull                # Pull remote state
terraform state push                # Push local state
terraform refresh                   # Sync state with real infrastructure
```

### Output and Inspection
```bash
terraform output              # Show all outputs
terraform output <name>       # Show specific output
terraform output -json        # Output in JSON format
terraform output -raw <name>  # Raw output (no quotes)
terraform show                # Show current state
```

### Validation and Formatting
```bash
terraform fmt                    # Format files in current directory
terraform fmt -recursive         # Format all files recursively
terraform fmt -check             # Check if files are formatted
terraform validate               # Validate configuration syntax
terraform validate -json         # JSON output for CI/CD
```

### Workspace Management
```bash
terraform workspace list         # List workspaces
terraform workspace new <name>   # Create new workspace
terraform workspace select <name> # Switch workspace
terraform workspace show         # Show current workspace
terraform workspace delete <name> # Delete workspace
```

### Import and Graph
```bash
terraform import <resource> <id>  # Import existing resource
terraform graph                   # Generate dependency graph
terraform graph | dot -Tpng > graph.png  # Visualize graph
```

### Other Useful Commands
```bash
terraform version              # Show Terraform version
terraform providers            # Show provider requirements
terraform console              # Interactive console
terraform get                  # Download modules
terraform taint <resource>     # Mark resource for recreation
terraform untaint <resource>   # Remove taint mark
terraform force-unlock <ID>    # Force unlock state (use carefully)
```

## HCL Syntax

### Resource Block
```hcl
resource "resource_type" "resource_name" {
  argument1 = "value1"
  argument2 = "value2"
  
  nested_block {
    nested_argument = "value"
  }
}
```

### Variable Declaration
```hcl
variable "variable_name" {
  description = "Description of the variable"
  type        = string  # string, number, bool, list, map, set, object, tuple
  default     = "default_value"
  sensitive   = false
  
  validation {
    condition     = length(var.variable_name) > 0
    error_message = "Variable must not be empty."
  }
}
```

### Output Declaration
```hcl
output "output_name" {
  description = "Description of the output"
  value       = resource.type.name.attribute
  sensitive   = false
}
```

### Data Source
```hcl
data "data_type" "data_name" {
  filter {
    name   = "filter_name"
    values = ["filter_value"]
  }
}
```

### Provider Configuration
```hcl
provider "provider_name" {
  region = "us-east-1"
  
  default_tags {
    tags = {
      Environment = "dev"
    }
  }
}
```

### Module Usage
```hcl
module "module_name" {
  source = "./modules/module_path"
  
  input_variable1 = "value1"
  input_variable2 = "value2"
}
```

### Locals
```hcl
locals {
  common_tags = {
    Project     = "MyProject"
    Environment = var.environment
  }
  
  instance_name = "${var.project}-${var.environment}-instance"
}
```

### Terraform Block
```hcl
terraform {
  required_version = ">= 1.0"
  
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
  
  backend "s3" {
    bucket = "my-terraform-state"
    key    = "terraform.tfstate"
    region = "us-east-1"
  }
}
```

## Variable Types

### String
```hcl
variable "instance_type" {
  type    = string
  default = "t2.micro"
}
```

### Number
```hcl
variable "instance_count" {
  type    = number
  default = 2
}
```

### Bool
```hcl
variable "enable_monitoring" {
  type    = bool
  default = true
}
```

### List
```hcl
variable "availability_zones" {
  type    = list(string)
  default = ["us-east-1a", "us-east-1b"]
}
```

### Map
```hcl
variable "instance_tags" {
  type = map(string)
  default = {
    Name = "MyInstance"
    Env  = "dev"
  }
}
```

### Object
```hcl
variable "instance_config" {
  type = object({
    instance_type = string
    ami           = string
  })
}
```

## Built-in Functions

### String Functions
```hcl
upper("hello")              # "HELLO"
lower("HELLO")              # "hello"
title("hello world")        # "Hello World"
trim("  hello  ", " ")      # "hello"
format("Hello, %s", "World") # "Hello, World"
join(", ", ["a", "b", "c"]) # "a, b, c"
split(",", "a,b,c")         # ["a", "b", "c"]
substr("hello", 1, 3)       # "ell"
replace("hello", "l", "r")  # "herro"
```

### Numeric Functions
```hcl
max(5, 12, 9)               # 12
min(5, 12, 9)               # 5
abs(-12)                    # 12
ceil(5.1)                   # 6
floor(5.9)                  # 5
```

### Collection Functions
```hcl
length([1, 2, 3])           # 3
element([1, 2, 3], 1)       # 2
concat([1, 2], [3, 4])      # [1, 2, 3, 4]
contains([1, 2, 3], 2)      # true
merge(map1, map2)           # Merge maps
keys({a = 1, b = 2})        # ["a", "b"]
values({a = 1, b = 2})      # [1, 2]
lookup({a = 1}, "a", 0)     # 1
```

### Encoding Functions
```hcl
base64encode("hello")       # Encode to base64
base64decode("aGVsbG8=")    # Decode from base64
jsonencode({a = 1})         # Convert to JSON
jsondecode('{"a": 1}')      # Parse JSON
```

### Filesystem Functions
```hcl
file("path/to/file")        # Read file content
fileexists("file.txt")      # Check if file exists
templatefile("file.tpl", vars) # Render template
```

### Date/Time Functions
```hcl
timestamp()                 # Current timestamp
formatdate("YYYY-MM-DD", timestamp())
```

### Type Conversion
```hcl
tostring(123)               # "123"
tonumber("123")             # 123
tobool("true")              # true
tolist(["a", "b"])          # Convert to list
tomap({a = 1})              # Convert to map
```

## Common Patterns

### Conditional Expression
```hcl
instance_type = var.environment == "prod" ? "t2.large" : "t2.micro"
```

### For Expression
```hcl
[for s in var.list : upper(s)]
{for k, v in var.map : k => upper(v)}
```

### Dynamic Blocks
```hcl
dynamic "ingress" {
  for_each = var.ingress_rules
  content {
    from_port   = ingress.value.from_port
    to_port     = ingress.value.to_port
    protocol    = ingress.value.protocol
    cidr_blocks = ingress.value.cidr_blocks
  }
}
```

### Count Meta-Argument
```hcl
resource "aws_instance" "server" {
  count         = 3
  instance_type = "t2.micro"
  
  tags = {
    Name = "server-${count.index}"
  }
}
```

### For_Each Meta-Argument
```hcl
resource "aws_instance" "server" {
  for_each = toset(["web", "app", "db"])
  
  instance_type = "t2.micro"
  
  tags = {
    Name = each.key
  }
}
```

### Lifecycle Rules
```hcl
resource "aws_instance" "example" {
  # ... other configuration ...
  
  lifecycle {
    create_before_destroy = true
    prevent_destroy       = false
    ignore_changes        = [tags]
  }
}
```

### Dependencies
```hcl
resource "aws_instance" "example" {
  # Explicit dependency
  depends_on = [aws_security_group.example]
}
```

## Environment Variables

```bash
# AWS credentials
export AWS_ACCESS_KEY_ID="..."
export AWS_SECRET_ACCESS_KEY="..."
export AWS_DEFAULT_REGION="us-east-1"

# Terraform variables
export TF_VAR_instance_type="t2.micro"
export TF_VAR_region="us-east-1"

# Terraform behavior
export TF_LOG=DEBUG  # TRACE, DEBUG, INFO, WARN, ERROR
export TF_LOG_PATH="terraform.log"
export TF_INPUT=0    # Disable interactive input
```

## Tips and Tricks

### Plan with Variables
```bash
terraform plan -var="instance_type=t2.small"
terraform plan -var-file="prod.tfvars"
```

### Target Specific Resources
```bash
terraform apply -target=aws_instance.web
terraform destroy -target=aws_instance.web
```

### Debugging
```bash
export TF_LOG=DEBUG
terraform apply
```

### Quick Plan
```bash
terraform plan -compact-warnings
```

### State Backup
```bash
cp terraform.tfstate terraform.tfstate.backup
```

### Format on Save (VS Code)
Add to `.vscode/settings.json`:
```json
{
  "[terraform]": {
    "editor.formatOnSave": true
  }
}
```

## Best Practices

1. **Always run `terraform plan` before `apply`**
2. **Use version constraints for providers**
3. **Store state remotely in production**
4. **Use variables for reusability**
5. **Tag all resources**
6. **Use modules for reusable components**
7. **Keep configurations DRY (Don't Repeat Yourself)**
8. **Use `.gitignore` for sensitive files**
9. **Document your code**
10. **Use workspaces for environments**

## Common Errors and Solutions

| Error | Solution |
|-------|----------|
| `Error: Failed to get existing workspaces` | Run `terraform init -reconfigure` |
| `Error: Resource already exists` | Import with `terraform import` |
| `Error: state lock` | Run `terraform force-unlock <ID>` |
| `Error: Provider version conflict` | Specify version constraints |
| `Error: Reference to undeclared resource` | Check resource names and dependencies |

## Quick Reference Links

- [Terraform Documentation](https://www.terraform.io/docs)
- [Terraform Registry](https://registry.terraform.io/)
- [AWS Provider Docs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs)
- [Built-in Functions](https://www.terraform.io/language/functions)
- [Configuration Syntax](https://www.terraform.io/language/syntax)

---

**Save this cheat sheet for quick reference!** 📋
