# Mini Project 2: AWS EC2 Instance

## Overview
Deploy a simple EC2 instance on AWS with proper security groups and tags. This project introduces you to cloud infrastructure management with Terraform.

## What You'll Learn
- Working with cloud providers (AWS)
- Creating EC2 instances
- Managing security groups
- Using data sources
- AWS authentication
- Tagging resources

## Prerequisites
- Terraform installed
- AWS Account
- AWS CLI installed and configured
- Basic understanding of AWS services

## AWS Setup

### 1. Install AWS CLI
```bash
# macOS
brew install awscli

# Linux
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install
```

### 2. Configure AWS Credentials
```bash
aws configure
```

Enter your:
- AWS Access Key ID
- AWS Secret Access Key
- Default region (e.g., us-east-1)
- Default output format (json)

### 3. Verify Configuration
```bash
aws sts get-caller-identity
```

## Project Structure
```
02-aws-ec2/
├── README.md           (this file)
├── main.tf             (main configuration)
├── variables.tf        (input variables)
├── outputs.tf          (output values)
├── security-groups.tf  (security group configuration)
└── terraform.tfvars.example  (example variable values)
```

## Instructions

### Step 1: Navigate to project directory
```bash
cd examples/02-aws-ec2
```

### Step 2: Create terraform.tfvars
```bash
cp terraform.tfvars.example terraform.tfvars
# Edit terraform.tfvars to set your preferred region and instance type
```

### Step 3: Initialize Terraform
```bash
terraform init
```

### Step 4: Preview the infrastructure
```bash
terraform plan
```

Review what will be created:
- 1 EC2 instance
- 1 Security group (allowing SSH)
- Associated tags

### Step 5: Apply the configuration
```bash
terraform apply
```

Type `yes` when prompted. This will:
- Create a security group
- Launch an EC2 instance
- Apply tags

**Note**: This will incur AWS charges (minimal for t2.micro/t3.micro instances).

### Step 6: View outputs
```bash
terraform output
```

You'll see:
- Instance ID
- Public IP address
- Instance state

### Step 7: Verify in AWS Console
1. Log into AWS Console
2. Navigate to EC2 Dashboard
3. Find your instance by name: "terraform-demo-instance"

### Step 8: SSH into the instance (optional)
First, you'll need a key pair:
```bash
# Create a key pair in AWS Console or use an existing one
# Update terraform.tfvars with your key name
# Then apply again
```

SSH command:
```bash
ssh -i /path/to/your-key.pem ec2-user@<instance_public_ip>
```

### Step 9: Destroy resources
**Important**: Always destroy resources to avoid unnecessary charges!
```bash
terraform destroy
```

Type `yes` to confirm deletion.

## Cost Estimate

- **t2.micro** (Free Tier eligible): $0.00 - $0.0116/hour
- **t3.micro**: ~$0.0104/hour

**Free Tier**: AWS offers 750 hours/month of t2.micro instances for the first 12 months.

## Security Considerations

1. **Security Groups**: The default config allows SSH (port 22) from any IP (0.0.0.0/0)
   - **Production**: Restrict to your IP address
   - Update `allowed_ssh_cidr` in terraform.tfvars

2. **Key Pairs**: Store private keys securely
   - Never commit keys to version control
   - Use proper file permissions: `chmod 400 key.pem`

3. **IAM Permissions**: Use minimal required permissions
   - Don't use root credentials
   - Create IAM user with EC2 permissions

## What's Happening?

1. **Provider Configuration**: Connects to AWS in specified region
2. **Data Source**: Fetches the latest Amazon Linux 2 AMI
3. **Security Group**: Creates firewall rules for the instance
4. **EC2 Instance**: Launches a virtual machine with specified configuration
5. **Tags**: Adds metadata for organization and cost tracking

## Key Concepts Demonstrated

### Provider Block
```hcl
provider "aws" {
  region = var.aws_region
}
```

### Data Source
```hcl
data "aws_ami" "amazon_linux" {
  # Fetches latest AMI without hardcoding ID
}
```

### Resource Dependencies
Terraform automatically understands that EC2 depends on the security group.

### Tags
```hcl
tags = {
  Name = "my-instance"
}
```

## Customization Ideas

1. **Change instance size**: Modify `instance_type` variable
2. **Add more security rules**: Edit security-groups.tf
3. **Use different AMI**: Modify the data source filter
4. **Add user data**: Include bootstrap scripts
5. **Create multiple instances**: Use `count` parameter

## Troubleshooting

### Error: "AuthFailure"
**Solution**: Check AWS credentials with `aws configure list`

### Error: "UnauthorizedOperation"
**Solution**: Ensure IAM user has EC2 permissions

### Error: "InvalidKeyPair.NotFound"
**Solution**: Create key pair in AWS Console or remove key_name parameter

### Error: "VPCIdNotSpecified"
**Solution**: Ensure you're using default VPC or specify vpc_id

## Next Steps

After completing this project:
- [Project 3: Multi-Tier Web Application](../03-multi-tier-app/)
- Learn about VPCs, subnets, and advanced networking
- Build a complete application infrastructure

## Additional Resources

- [AWS Provider Documentation](https://registry.terraform.io/providers/hashicorp/aws/latest/docs)
- [AWS EC2 Documentation](https://docs.aws.amazon.com/ec2/)
- [Terraform AWS Examples](https://github.com/hashicorp/terraform-provider-aws/tree/main/examples)
