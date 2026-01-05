variable "region" {
  description = "AWS region"
  type        = string
  default     = "ap-south-1"
}

variable "vpc_cidr" {
  description = "CIDR block for VPC myvpc"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidr" {
  description = "CIDR block for public subnet pubsubnet"
  type        = string
  default     = "10.0.2.0/20"
}

variable "private_subnet_cidr" {
  description = "CIDR block for private subnet pvtsubnet"
  type        = string
  default     = "10.0.1.0/20"
}

variable "public_az" {
  description = "Availability zone for public subnet"
  type        = string
  default     = "ap-south-1b"
}

variable "private_az" {
  description = "Availability zone for private subnet"
  type        = string
  default     = "ap-south-1a"
}

variable "vpc_name" {
  description = "Name tag for VPC"
  type        = string
  default     = "prod-vpc"
}

variable "public_subnet_name" {
  description = "Name tag for public subnet"
  type        = string
  default     = "public-subnet"
}

variable "private_subnet_name" {
  description = "Name tag for private subnet"
  type        = string
  default     = "private-subnet"
}

variable "igw_name" {
  description = "Name tag for Internet Gateway"
  type        = string
  default     = "prod-igw"
}