provider "aws" {
  region = "ap-south-1"
}

# data "aws_security_groups" "mysg" {
#   filter {
#     name   = "vpc-id"
#     values =[var.vpc_id]
#   }
#   filter {
#     name   = "group-name"
#     values = ["mysg"]
#   }
# }

data "aws_security_group" "mysg" {
  filter {
    name   = "mysg"
    values = ["mysg"]
  }

  vpc_id = var.vpc_id
}


resource "aws_instance" "myinstance" {
    ami = var.ami_id
    instance_type = var.instance_type
    vpc_security_group_ids = [data.aws_security_group.mysg.id]
    key_name = var.key_name
    availability_zone = var.availability_zone
    tags = {
  Name = local.instance_name
}

  # tags = {
  #   name = local.instance_name
  # }
}

terraform {
  backend "s3" {
    bucket = "amzn-tf-s3"
    region = "ap-south-1"
    key = "tfstate"
  }
}

locals {
  instance_name = "my-instance"
}
variable "ami_id" {
  default = "ami-087d1c9a513324697"
  description = "this is my new ami id"
}
variable "instance_type" {
  default = "t3.micro"
}
variable "key_name" {
  default = "id_rsa_key"
}
variable "availability_zone" {
  default = "ap-south-1b"
}
variable "vpc_id" {
  default = "vpc-0fc56b6da92c7716b"
}
output "instance_public_ip" {
  value = aws_instance.myinstance.public_ip
}
output "instance_id" {
  value = aws_instance.myinstance.id
}
