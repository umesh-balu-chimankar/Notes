provider "aws" {
  region = "ap-south-1"
}
resource "aws_instance" "myinstance" {
    ami = "ami-087d1c9a513324697"
    instance_type = "t3.micro"
    vpc_security_group_ids = ["sg-000d393420ab317b8"]
    key_name = "id_rsa_key"
    availability_zone = "ap-south-1b"
  tags = {
    name = "myinstance"
  }
}

terraform {
  backend "s3" {
    bucket = "amzn-tf-s3"
    region = "ap-south-1"
    key = "tfstate"
  }
}