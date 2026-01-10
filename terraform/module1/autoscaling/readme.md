# 📘 Terraform Line-by-Line Explanation (With Comments)

## 📂 main.tf (Fully Commented)

```hcl
# AWS provider block – tells Terraform which cloud and region to use
provider "aws" {
  region = "ap-south-1"   # Mumbai AWS region
}

# Data block – fetches existing security groups from AWS
data "aws_security_groups" "mysg" {

  # Filter security groups by VPC ID
  filter {
    name   = "vpc-id"           # Filter key
    values = [var.vpc_id]       # Value comes from variable.tf
  }

  # Filter by security group name
  filter {
    name   = "group-name"       # Filter key
    values = ["mysg"]           # Exact SG name in AWS
  }
}

# EC2 instance resource – creates a virtual server
resource "aws_instance" "myinstance" {

  ami           = var.ami_id          # AMI ID from variable
  instance_type = var.instance_type   # Instance type (t2.micro, etc.)

  # Security group ID attached to EC2
  vpc_security_group_ids = ["sg-0ea643e0e5465c1d3"]

  # Alternative dynamic way (recommended)
  # vpc_security_group_ids = data.aws_security_groups.mysg.ids

  key_name = var.key_name              # SSH key pair name
  availability_zone = var.availability_zone  # AZ like ap-south-1a

  # Tags help identify resources
  tags = {
    Name = local.instance_name
  }
}

# Terraform backend configuration – stores state remotely
terraform {
  backend "s3" {
    bucket = "amzn-tf-s3"      # S3 bucket for tfstate
    key    = "tfstate"         # State file name
    region = "ap-south-1"      # Bucket region
  }
}

# Local values – reusable internal variables
locals {
  instance_name = "my-instance"   # Used in EC2 tags
}
```

---

## 📂 variable.tf (Fully Commented)

```hcl
# AMI ID variable
variable "ami_id" {
  description = "AMI ID for EC2 instance"
}

# Instance type variable
variable "instance_type" {
  description = "EC2 instance size"
  default     = "t2.micro"
}

# Key pair variable
variable "key_name" {
  description = "SSH key pair name"
}

# Availability Zone variable
variable "availability_zone" {
  description = "AWS availability zone"
}

# VPC ID variable
variable "vpc_id" {
  description = "VPC ID where EC2 will be launched"
}
```

---

## 📂 output.tf (Fully Commented)

```hcl
# Output EC2 instance ID
output "instance_id" {
  value = aws_instance.myinstance.id
  description = "EC2 Instance ID"
}

# Output public IP
output "public_ip" {
  value = aws_instance.myinstance.public_ip
  description = "Public IP of EC2"
}
```

---

## ✅ WHY EACH BLOCK IS USED

### Provider Block
- Connects Terraform to AWS
- Mandatory for cloud resources

### Data Block
- Reads existing AWS resources
- Prevents hardcoding IDs

### Resource Block
- Creates actual AWS infrastructure
- Core of Terraform

### Variables
- Makes code reusable
- Environment-friendly

### Backend
- Enables team collaboration
- Prevents state loss

### Outputs
- Shows useful info after apply
- Helps automation & debugging

---

## ⚖️ Advantages & Disadvantages

### ✅ Advantages
- Infrastructure as Code
- Version control friendly
- Fully automated

### ❌ Disadvantages
- Learning curve
- Errors stop deployment

---

## 🏆 Best Practices
- Use remote backend
- Avoid hardcoding IDs
- Use modules for large projects
- Store secrets in AWS Secrets Manager



