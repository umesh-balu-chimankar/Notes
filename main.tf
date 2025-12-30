locals {
  instance_name = "my-instance"
}
terraform {
  backend "s3" {
    bucket = "amzn-tf-s3"
    region = "ap-south-1"
    key = "tfstate"
  }
}
data "aws_security_group" "my-sg" {
  filter {
    name   = "vpc-id"
    values =[var.vpc_id]
  }
  filter {
    name   = "group-name"
    values = ["my-sg"]
  }
}
resource "aws_instance" "myinstance" {
    ami = var.ami_id
    instance_type = var.instance_type
   vpc_security_group_ids = [data.aws_security_group.my-sg.id]
    key_name = var.key_name
    availability_zone = var.availability_zone
    tags = {
  Name = local.instance_name
}
}