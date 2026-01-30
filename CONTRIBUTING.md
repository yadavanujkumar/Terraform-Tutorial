# Contributing to Terraform Tutorial

Thank you for considering contributing to this Terraform tutorial! We welcome contributions from everyone.

## How to Contribute

### Reporting Issues

If you find a bug, typo, or have a suggestion:

1. Check if the issue already exists
2. Create a new issue with a clear title and description
3. Include steps to reproduce (if it's a bug)
4. Add relevant labels

### Contributing Code

1. **Fork the repository**
   ```bash
   # Click "Fork" on GitHub, then:
   git clone https://github.com/YOUR_USERNAME/Terraform-Tutorial.git
   cd Terraform-Tutorial
   ```

2. **Create a branch**
   ```bash
   git checkout -b feature/your-feature-name
   # or
   git checkout -b fix/your-fix-name
   ```

3. **Make your changes**
   - Follow existing code style
   - Test your Terraform configurations
   - Update documentation if needed

4. **Commit your changes**
   ```bash
   git add .
   git commit -m "Add: brief description of your changes"
   ```

5. **Push to your fork**
   ```bash
   git push origin feature/your-feature-name
   ```

6. **Create a Pull Request**
   - Go to the original repository on GitHub
   - Click "New Pull Request"
   - Select your fork and branch
   - Add a clear description of your changes

## Types of Contributions

### Documentation Improvements
- Fix typos or unclear explanations
- Add more examples
- Improve README files
- Add troubleshooting tips

### New Examples
- Add new mini-projects
- Add examples for different cloud providers (Azure, GCP)
- Add examples for different services

### Bug Fixes
- Fix errors in Terraform configurations
- Fix broken links
- Correct outdated information

### Enhancements
- Improve existing examples
- Add more variables and outputs
- Add validation rules
- Improve security configurations

## Guidelines

### Terraform Code Standards

1. **Formatting**
   ```bash
   terraform fmt -recursive
   ```

2. **Validation**
   ```bash
   terraform validate
   ```

3. **Use meaningful names**
   ```hcl
   # Good
   resource "aws_instance" "web_server" { }
   
   # Bad
   resource "aws_instance" "x" { }
   ```

4. **Add comments for complex logic**
   ```hcl
   # Calculate instance count based on environment
   count = var.environment == "prod" ? 3 : 1
   ```

5. **Use variables for configurable values**
   ```hcl
   # Good
   instance_type = var.instance_type
   
   # Bad
   instance_type = "t2.micro"
   ```

6. **Add validation rules**
   ```hcl
   variable "environment" {
     validation {
       condition     = contains(["dev", "staging", "prod"], var.environment)
       error_message = "Environment must be dev, staging, or prod."
     }
   }
   ```

### Documentation Standards

1. **Clear explanations**: Write for beginners
2. **Step-by-step instructions**: Make it easy to follow
3. **Expected outputs**: Show what users should see
4. **Troubleshooting**: Include common issues and solutions
5. **Cost information**: Mention AWS/cloud charges where applicable

### File Organization

```
examples/XX-project-name/
├── README.md           # Detailed project guide
├── main.tf             # Main configuration
├── variables.tf        # Input variables
├── outputs.tf          # Output values
├── other.tf            # Other logical groupings
└── terraform.tfvars.example  # Example values
```

### Commit Message Format

Use clear, descriptive commit messages:

```
Add: AWS Lambda function example
Fix: Typo in README installation section
Update: Terraform AWS provider to version 5.0
Docs: Add troubleshooting section for EC2 example
```

## Testing Your Changes

### For Code Changes

1. **Initialize Terraform**
   ```bash
   terraform init
   ```

2. **Validate syntax**
   ```bash
   terraform validate
   ```

3. **Check formatting**
   ```bash
   terraform fmt -check -recursive
   ```

4. **Test the configuration**
   ```bash
   terraform plan
   terraform apply  # If safe to do so
   terraform destroy
   ```

### For Documentation Changes

1. Check for typos and grammar
2. Verify all links work
3. Test any code snippets
4. Ensure formatting is correct

## Code Review Process

All contributions go through code review:

1. A maintainer will review your PR
2. They may request changes or ask questions
3. Make requested changes and push to your branch
4. Once approved, your PR will be merged

## Questions?

If you have questions:
- Open an issue for discussion
- Tag it with "question" label
- A maintainer will respond

## License

By contributing, you agree that your contributions will be licensed under the MIT License.

## Code of Conduct

### Our Standards

- Be respectful and inclusive
- Welcome newcomers
- Accept constructive criticism
- Focus on what's best for the community

### Unacceptable Behavior

- Harassment or discriminatory language
- Trolling or insulting comments
- Personal or political attacks
- Publishing others' private information

## Recognition

Contributors will be recognized in:
- GitHub contributors list
- Release notes (for significant contributions)

Thank you for helping make this tutorial better! 🙏
