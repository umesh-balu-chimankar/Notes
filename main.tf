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
data "aws_security_group" "mysg" {
  filter {
    name   = "vpc-id"
    values =[var.vpc_id]
  }
  filter {
    name   = "group-name"
    values = ["mysg"]
  }
}
resource "aws_instance" "myinstance" {
    ami = var.ami_id
    instance_type = var.instance_type
    #vpc_security_group_ids = ["sg-0ea643e0e5465c1d3"]
   vpc_security_group_ids = [data.aws_security_group.mysg.id]
    key_name = var.key_name
    availability_zone = var.availability_zone
    tags = {
  Name = local.instance_name
}
}