provider "aws" {
  region = "ap-south-1"
}
resource "aws_instance" "myinstance" {
    ami = var.ami_id
    instance_type = var.instance_type
    vpc_security_group_ids = ["sg-000d393420ab317b8"]
    key_name = var.key_name
    availability_zone = "ap-south-1b"
  tags = {
    name = "myinstance1"
  }
}

terraform {
  backend "s3" {
    bucket = "amzn-tf-s3"
    region = "ap-south-1"
    key = "tfstate"
  }
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
output "instance_public_ip" {
  value = aws_instance.myinstance.public_ip
}
output "instance_id" {
  value = aws_instance.myinstance.id
}