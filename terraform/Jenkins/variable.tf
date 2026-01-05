variable "region" {
  description = "AWS region"
  type        = string
  default     = "eu-west-3"
}

variable "ami_id" {
  description = "AMI ID (Amazon Linux 2)"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro"
}

variable "key_name" {
  description = "EC2 key pair name"
  type        = string
  default     = "paris-key"
}

variable "security_group_ids" {
  description = "Security group IDs for Jenkins instance"
  type        = list(string)
  default     = ["sg-035d9053b01e56d1a"]
}

variable "instance_name" {
  description = "EC2 instance name"
  type        = string
  default     = "jenkins-terraform"
}

variable "environment" {
  description = "Environment tag"
  type        = string
  default     = "dev"
}
