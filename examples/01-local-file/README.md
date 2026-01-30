# Mini Project 1: Local File Management

## Overview
This is the simplest Terraform project to help you understand the basics without needing cloud credentials.

## What You'll Learn
- Basic Terraform configuration syntax
- Terraform workflow (init, plan, apply, destroy)
- Resource creation
- Outputs
- Variables

## Prerequisites
- Terraform installed on your machine

## Project Structure
```
01-local-file/
├── README.md          (this file)
├── main.tf            (main configuration)
├── variables.tf       (input variables)
├── outputs.tf         (output values)
└── terraform.tfvars.example  (example variable values)
```

## Files Explanation

### main.tf
Contains the main Terraform configuration including the provider and resources.

### variables.tf
Defines input variables that can be customized.

### outputs.tf
Defines what information to display after applying the configuration.

## Instructions

### Step 1: Navigate to the project directory
```bash
cd examples/01-local-file
```

### Step 2: Create a terraform.tfvars file (optional)
```bash
cp terraform.tfvars.example terraform.tfvars
# Edit terraform.tfvars to customize values
```

### Step 3: Initialize Terraform
```bash
terraform init
```

This command:
- Downloads the required provider plugins (local provider)
- Initializes the backend for state storage
- Prepares the working directory

### Step 4: Format the code (optional)
```bash
terraform fmt
```

### Step 5: Validate the configuration
```bash
terraform validate
```

### Step 6: Preview the changes
```bash
terraform plan
```

This shows you what Terraform will create without making actual changes.

### Step 7: Apply the configuration
```bash
terraform apply
```

Type `yes` when prompted. This will create the files and directories.

### Step 8: Verify the outputs
```bash
terraform output
```

Or check the created files:
```bash
ls -la terraform-files/
cat terraform-files/welcome.txt
cat terraform-files/info.json
```

### Step 9: Make a change
Try editing `terraform.tfvars` to change the welcome message, then:
```bash
terraform plan
terraform apply
```

Notice how Terraform detects and applies only the changes.

### Step 10: Destroy resources
```bash
terraform destroy
```

Type `yes` to remove all created files and directories.

## What's Happening?

1. **Terraform Init**: Downloads the `local` provider plugin
2. **Terraform Plan**: Compares desired state (config) with current state (terraform.tfstate)
3. **Terraform Apply**: Creates resources and updates the state file
4. **Terraform Destroy**: Removes all resources tracked in the state

## Key Concepts Demonstrated

### Resource Block
```hcl
resource "resource_type" "resource_name" {
  # configuration
}
```

### Variable Usage
```hcl
var.variable_name
```

### String Interpolation
```hcl
"Hello, ${var.name}!"
```

### Path References
```hcl
path.module  # Current module directory
```

## Experiment Ideas

1. Add more file resources
2. Create nested directories
3. Use different file permissions
4. Create files with dynamic content using `templatefile()` function
5. Use `count` to create multiple files

## Common Issues

### Issue: Permission denied
**Solution**: Ensure you have write permissions in the directory

### Issue: File already exists
**Solution**: Run `terraform destroy` first or remove the files manually

## Next Steps

After mastering this project, move on to:
- [Project 2: AWS EC2 Instance](../02-aws-ec2/)
- Learn about cloud providers
- Work with real infrastructure

## Additional Resources

- [Local Provider Documentation](https://registry.terraform.io/providers/hashicorp/local/latest/docs)
- [Terraform Language Documentation](https://www.terraform.io/language)
