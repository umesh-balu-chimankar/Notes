# provider "aws" {
#   region = "ap-south-1"
# }
# resource "aws_instance" "myinstance" {
#     ami = "ami-087d1c9a513324697"
#     instance_type = "t3.micro"
#     vpc_security_group_ids = ["sg-038c233d26eb54582"]
#     key_name = "id_rsa_key"
#     availability_zone = "ap-south-1"
#   tags = {
#     name = "myinstance"
#   }
# }

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "ap-south-1"
}

resource "aws_instance" "myinstance" {
  ami                    = "ami-087d1c9a513324697"
  instance_type          = "t3.micro"
  vpc_security_group_ids = ["sg-038c233d26eb54582"]
  key_name               = "id_rsa_key"
  availability_zone      = "ap-south-1a"

  tags = {
    Name = "myinstance"
  }
}
