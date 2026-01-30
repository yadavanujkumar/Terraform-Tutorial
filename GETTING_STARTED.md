# Getting Started with Terraform

This guide will walk you through setting up Terraform and running your first infrastructure code.

## Table of Contents
- [Installation](#installation)
- [First Steps](#first-steps)
- [Working with the Examples](#working-with-the-examples)
- [Common Issues](#common-issues)
- [Tips for Beginners](#tips-for-beginners)

## Installation

### macOS

Using Homebrew (recommended):
```bash
brew tap hashicorp/tap
brew install hashicorp/tap/terraform
```

Or download manually from [terraform.io](https://www.terraform.io/downloads).

### Linux (Ubuntu/Debian)

```bash
wget -O- https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
sudo apt update
sudo apt install terraform
```

### Linux (Fedora/RHEL)

```bash
sudo dnf install -y dnf-plugins-core
sudo dnf config-manager --add-repo https://rpm.releases.hashicorp.com/fedora/hashicorp.repo
sudo dnf install terraform
```

### Windows

**Option 1: Chocolatey**
```powershell
choco install terraform
```

**Option 2: Manual Installation**
1. Download from [terraform.io/downloads](https://www.terraform.io/downloads)
2. Extract the zip file
3. Add the directory to your PATH

### Verify Installation

```bash
terraform version
```

You should see output like:
```
Terraform v1.6.0
on darwin_arm64
```

## First Steps

### 1. Choose a Text Editor

We recommend **Visual Studio Code** with the following extensions:
- HashiCorp Terraform
- Terraform doc snippets
- Terraform Autocomplete

Or use any text editor you're comfortable with.

### 2. Understand the Basic Workflow

```
Write → Init → Plan → Apply → Destroy
```

- **Write**: Create `.tf` files with your infrastructure code
- **Init**: Download provider plugins
- **Plan**: Preview what will change
- **Apply**: Create/update infrastructure
- **Destroy**: Remove infrastructure

### 3. Learn the Basic Commands

```bash
terraform init      # Initialize working directory
terraform fmt       # Format code
terraform validate  # Validate syntax
terraform plan      # Preview changes
terraform apply     # Apply changes
terraform destroy   # Destroy infrastructure
terraform show      # Show current state
terraform output    # Display outputs
```

## Working with the Examples

### Example 1: Local File Management (No Cloud Account Needed!)

This is the perfect starting point:

```bash
cd examples/01-local-file
terraform init
terraform plan
terraform apply
# Type 'yes' when prompted
ls terraform-files/
terraform destroy
```

**What you'll learn:**
- Basic Terraform syntax
- Resource creation
- Variables and outputs
- The Terraform workflow

### Example 2: AWS EC2 Instance

Before starting this example:

1. **Create AWS Account** (if you don't have one)
   - Go to [aws.amazon.com](https://aws.amazon.com)
   - Sign up for free tier

2. **Install AWS CLI**
   ```bash
   # macOS
   brew install awscli
   
   # Linux
   curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
   unzip awscliv2.zip
   sudo ./aws/install
   ```

3. **Create IAM User with Programmatic Access**
   - Go to AWS Console → IAM → Users → Add User
   - Enable "Programmatic access"
   - Attach "AmazonEC2FullAccess" policy
   - Save Access Key ID and Secret Access Key

4. **Configure AWS CLI**
   ```bash
   aws configure
   # Enter your Access Key ID
   # Enter your Secret Access Key
   # Enter region: us-east-1
   # Enter output format: json
   ```

5. **Run the example**
   ```bash
   cd examples/02-aws-ec2
   cp terraform.tfvars.example terraform.tfvars
   # Edit terraform.tfvars if needed
   terraform init
   terraform plan
   terraform apply
   # Remember to destroy when done!
   terraform destroy
   ```

**Important:** AWS charges apply. Use `terraform destroy` when done testing!

### Example 3: Multi-Tier Application

This is a more advanced example. Complete examples 1 and 2 first.

**Warning:** This creates multiple AWS resources and will incur charges (~$65-80/month if left running).

```bash
cd examples/03-multi-tier-app
cp terraform.tfvars.example terraform.tfvars
terraform init
terraform plan
terraform apply
# Test the application via the ALB URL provided in outputs
terraform destroy  # IMPORTANT: Don't forget!
```

## Common Issues

### Issue 1: "terraform: command not found"

**Solution:**
- Verify installation: Check if Terraform binary is in your PATH
- Restart your terminal after installation
- On Windows, you may need to add Terraform directory to PATH manually

### Issue 2: "Error: Failed to query available provider packages"

**Solution:**
```bash
terraform init -upgrade
```

### Issue 3: AWS Authentication Issues

**Solution:**
```bash
# Verify AWS credentials
aws sts get-caller-identity

# If it fails, reconfigure
aws configure
```

### Issue 4: "Error: Invalid character" on Windows

**Solution:**
- Use Git Bash, WSL, or PowerShell instead of Command Prompt
- Ensure files have LF line endings, not CRLF

### Issue 5: "Resource already exists"

**Solution:**
- Import existing resource: `terraform import <resource_type>.<name> <id>`
- Or destroy and recreate: `terraform destroy` then `terraform apply`

## Tips for Beginners

### 1. Always Use Version Control

```bash
git init
git add *.tf
git commit -m "Initial Terraform configuration"
```

Never commit:
- `terraform.tfstate` files (contain sensitive data)
- `.terraform/` directory (downloaded plugins)
- `*.tfvars` files (may contain secrets)

### 2. Use the Plan Command Liberally

Always run `terraform plan` before `terraform apply`:
```bash
terraform plan -out=tfplan
terraform apply tfplan
```

### 3. Organize Your Code

Recommended file structure:
```
project/
├── main.tf          # Main configuration
├── variables.tf     # Input variables
├── outputs.tf       # Output values
├── versions.tf      # Provider versions
└── terraform.tfvars # Variable values (don't commit if sensitive)
```

### 4. Use Comments

```hcl
# This security group allows SSH access
resource "aws_security_group" "allow_ssh" {
  # ... configuration
}
```

### 5. Start Simple

- Begin with example 1 (local files)
- Don't try to learn everything at once
- Master the basics before moving to complex architectures

### 6. Read Error Messages

Terraform provides helpful error messages. Read them carefully:
```
Error: Reference to undeclared resource
```
This tells you exactly what's wrong!

### 7. Use Terraform Console

Test expressions interactively:
```bash
terraform console
> var.instance_type
"t2.micro"
> upper("hello")
"HELLO"
```

### 8. Format Your Code

Always format before committing:
```bash
terraform fmt -recursive
```

### 9. Keep State Safe

- **Local development**: `terraform.tfstate` in project directory is fine
- **Team/Production**: Use remote backend (S3, Terraform Cloud)

### 10. Destroy Test Resources

Don't forget to clean up:
```bash
terraform destroy
```

## Learning Path

### Beginner (Week 1-2)
1. Complete Example 1: Local File Management
2. Learn HCL syntax
3. Understand: resources, variables, outputs
4. Practice: `init`, `plan`, `apply`, `destroy`

### Intermediate (Week 3-4)
1. Complete Example 2: AWS EC2
2. Learn about providers
3. Understand data sources
4. Learn about state management

### Advanced (Week 5-6)
1. Complete Example 3: Multi-Tier App
2. Learn about modules
3. Learn about remote state
4. Study provisioners and lifecycle rules

### Expert (Beyond)
1. Create reusable modules
2. Implement CI/CD pipelines
3. Use workspaces for multiple environments
4. Study advanced state management

## Next Steps

After working through the examples:

1. **Build Your Own Project**
   - Start with something simple
   - Gradually add complexity
   - Apply what you've learned

2. **Read Documentation**
   - [Terraform Documentation](https://www.terraform.io/docs)
   - [AWS Provider Docs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs)

3. **Join the Community**
   - [HashiCorp Forum](https://discuss.hashicorp.com/c/terraform-core)
   - [Reddit r/Terraform](https://reddit.com/r/Terraform)
   - [Stack Overflow](https://stackoverflow.com/questions/tagged/terraform)

4. **Practice Daily**
   - Consistency is key
   - Even 30 minutes daily helps
   - Build small projects regularly

## Additional Resources

### Official Resources
- [Terraform Registry](https://registry.terraform.io/) - Providers and modules
- [HashiCorp Learn](https://learn.hashicorp.com/terraform) - Official tutorials
- [Terraform Documentation](https://www.terraform.io/docs)

### Community Resources
- [Terraform Best Practices](https://www.terraform-best-practices.com/)
- [Awesome Terraform](https://github.com/shuaibiyy/awesome-terraform)
- [Terraform Examples](https://github.com/hashicorp/terraform-provider-aws/tree/main/examples)

### Video Tutorials
- [HashiCorp YouTube Channel](https://www.youtube.com/c/HashiCorp)
- [FreeCodeCamp Terraform Course](https://www.youtube.com/results?search_query=terraform+freecodecamp)

### Books
- "Terraform: Up & Running" by Yevgeniy Brikman
- "Infrastructure as Code" by Kief Morris

## Getting Help

If you're stuck:

1. **Read the error message carefully** - it usually tells you what's wrong
2. **Check the documentation** - search for the specific resource or error
3. **Search Google/Stack Overflow** - someone likely had the same issue
4. **Ask the community** - forums and Slack channels are helpful
5. **Review the examples** - look at working code for patterns

## Conclusion

Terraform is a powerful tool that gets easier with practice. Start with the simple examples, understand the concepts, and gradually build more complex infrastructure. Don't rush - take your time to understand each concept thoroughly.

Happy Terraforming! 🚀
