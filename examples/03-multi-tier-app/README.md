# Mini Project 3: Multi-Tier Web Application

## Overview
Build a complete production-like infrastructure with VPC, public/private subnets, NAT gateway, load balancer, and multiple EC2 instances. This project demonstrates real-world AWS architecture patterns.

## What You'll Learn
- Creating custom VPCs
- Managing subnets (public and private)
- Internet Gateway and NAT Gateway
- Application Load Balancer
- Auto-scaling concepts
- Multi-tier architecture
- Best practices for production environments

## Architecture

```
┌─────────────────────────────────────────────────────────┐
│                         VPC                              │
│                    (10.0.0.0/16)                        │
│                                                          │
│  ┌────────────────────┐  ┌────────────────────┐        │
│  │   Public Subnet     │  │   Public Subnet     │        │
│  │   (10.0.1.0/24)    │  │   (10.0.2.0/24)    │        │
│  │   AZ: us-east-1a   │  │   AZ: us-east-1b   │        │
│  │                     │  │                     │        │
│  │  ┌──────────────┐  │  │  ┌──────────────┐  │        │
│  │  │     ALB      │  │  │  │   NAT GW     │  │        │
│  │  └──────────────┘  │  │  └──────────────┘  │        │
│  └────────┬───────────┘  └──────────┬─────────┘        │
│           │                          │                   │
│  ┌────────┴───────────┐  ┌──────────┴─────────┐        │
│  │  Private Subnet     │  │  Private Subnet     │        │
│  │  (10.0.11.0/24)    │  │  (10.0.12.0/24)    │        │
│  │  AZ: us-east-1a    │  │  AZ: us-east-1b    │        │
│  │                     │  │                     │        │
│  │  ┌──────────────┐  │  │  ┌──────────────┐  │        │
│  │  │  Web Server  │  │  │  │  Web Server  │  │        │
│  │  └──────────────┘  │  │  └──────────────┘  │        │
│  └────────────────────┘  └────────────────────┘        │
│                                                          │
└─────────────────────────────────────────────────────────┘
```

## Components

1. **VPC**: Custom network with CIDR 10.0.0.0/16
2. **Subnets**: 2 public + 2 private across 2 availability zones
3. **Internet Gateway**: Allows public subnet resources to access internet
4. **NAT Gateway**: Allows private subnet resources to access internet
5. **Application Load Balancer**: Distributes traffic across web servers
6. **EC2 Instances**: Web servers in private subnets
7. **Security Groups**: Fine-grained access control

## Prerequisites
- Terraform installed
- AWS Account with sufficient permissions
- AWS CLI configured
- Understanding of networking basics

## Project Structure
```
03-multi-tier-app/
├── README.md           (this file)
├── main.tf             (main configuration)
├── vpc.tf              (VPC and networking)
├── security-groups.tf  (security group rules)
├── ec2.tf              (EC2 instances)
├── loadbalancer.tf     (ALB configuration)
├── variables.tf        (input variables)
├── outputs.tf          (output values)
└── terraform.tfvars.example
```

## Instructions

### Step 1: Navigate to project directory
```bash
cd examples/03-multi-tier-app
```

### Step 2: Create terraform.tfvars
```bash
cp terraform.tfvars.example terraform.tfvars
# Edit as needed
```

### Step 3: Initialize Terraform
```bash
terraform init
```

### Step 4: Preview the infrastructure
```bash
terraform plan
```

Review what will be created (~15 resources).

### Step 5: Apply the configuration
```bash
terraform apply
```

This takes 5-10 minutes due to NAT Gateway and ALB creation.

**Note**: This project will incur AWS charges (~$32-45/month if left running).

### Step 6: View outputs
```bash
terraform output
```

You'll see:
- VPC ID
- Subnet IDs
- Load Balancer DNS name
- Instance IDs

### Step 7: Test the application
```bash
# Get the load balancer URL
ALB_DNS=$(terraform output -raw alb_dns_name)
echo "Application URL: http://$ALB_DNS"

# Test the endpoint (wait a few minutes for instances to be healthy)
curl http://$ALB_DNS
```

Or open the URL in a browser.

### Step 8: Verify in AWS Console
1. **VPC Dashboard**: See the custom VPC
2. **EC2 Dashboard**: See instances in private subnets
3. **Load Balancers**: See the ALB distributing traffic
4. **Target Groups**: See health check status

### Step 9: Destroy resources
**IMPORTANT**: Destroy to avoid charges!
```bash
terraform destroy
```

This takes 5-10 minutes. Confirm with `yes`.

## Cost Estimate

**Monthly costs** (approximate):
- NAT Gateway: ~$32/month + data transfer
- Application Load Balancer: ~$16/month + LCU charges
- EC2 t2.micro instances (2): ~$17/month (not free tier eligible in private subnet with NAT)

**Total**: ~$65-80/month if left running

**Development tip**: Use `terraform destroy` after testing to minimize costs.

## Key Concepts

### 1. VPC (Virtual Private Cloud)
Isolated network in AWS where you deploy resources.

### 2. Subnets
- **Public**: Has route to Internet Gateway (direct internet access)
- **Private**: Routes through NAT Gateway (outbound only internet access)

### 3. Availability Zones
Deploying across multiple AZs provides high availability.

### 4. NAT Gateway
Allows private subnet resources to access internet (for updates, etc.) without being directly accessible from internet.

### 5. Application Load Balancer
- Distributes traffic across multiple targets
- Performs health checks
- Operates at Layer 7 (HTTP/HTTPS)

### 6. Security Groups
- Stateful firewalls
- Control inbound and outbound traffic
- Can reference other security groups

## Security Features

1. **Web servers in private subnets**: Not directly accessible from internet
2. **ALB in public subnet**: Only entry point for traffic
3. **Security group rules**: Strict access control
4. **No SSH keys required**: Using SSM Session Manager (optional)

## Customization Ideas

1. **Add RDS database**: Deploy database in private subnet
2. **Add Auto Scaling**: Automatically scale based on load
3. **Add CloudWatch**: Monitoring and alerting
4. **Add SSL/TLS**: HTTPS support with ACM certificate
5. **Add Bastion host**: SSH access to private instances
6. **Add S3 backend**: Store state remotely

## Troubleshooting

### Error: "InvalidSubnet"
**Solution**: Ensure AZs are available in your region

### Error: "Quota exceeded"
**Solution**: Check AWS service quotas (VPCs, EIPs, etc.)

### Load balancer returns 503
**Solution**: Wait for instances to pass health checks (2-3 minutes)

### Instances not accessible via ALB
**Solution**: Check security group rules and target group health

### High costs
**Solution**: Run `terraform destroy` when not testing

## Production Enhancements

For production use, consider adding:

1. **Multiple environments**: Use workspaces or separate state files
2. **Remote state**: Store in S3 with DynamoDB locking
3. **Modules**: Organize code into reusable modules
4. **SSL certificates**: HTTPS support
5. **Route53**: DNS management
6. **CloudWatch**: Monitoring and alarms
7. **Auto Scaling**: Dynamic capacity adjustment
8. **WAF**: Web Application Firewall
9. **Secrets Manager**: Secure credential storage
10. **CI/CD integration**: Automated deployments

## Next Steps

After mastering this project:
- Learn about Terraform modules
- Implement remote state backend
- Add CI/CD with GitHub Actions
- Study advanced AWS services (RDS, ElastiCache, ECS)
- Explore multi-region deployments

## Additional Resources

- [AWS VPC Documentation](https://docs.aws.amazon.com/vpc/)
- [AWS Load Balancer Documentation](https://docs.aws.amazon.com/elasticloadbalancing/)
- [Terraform AWS Provider](https://registry.terraform.io/providers/hashicorp/aws/latest/docs)
- [AWS Well-Architected Framework](https://aws.amazon.com/architecture/well-architected/)
