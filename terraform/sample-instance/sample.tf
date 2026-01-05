# locals {
#   instance_name = "my-instance"
# }
# terraform {
#   backend "s3" {
#     bucket = "batch151234"
#     region = "us-east-1"
#     key = "tfstate"
#   }
# }
# provider "aws" {
#   region = "us-east-1"
# }
# data "aws_security_group" "mysg" {
#   filter {
#     name   = "vpc-id"
#     values =[var.vpc_id]
#   }
#   filter {
#     name   = "group-name"
#     values = ["mysg"]
#   }
# }
# resource "aws_instance" "myinstance" {
#   ami = var.ami_id
#   instance_type = var.instance_type
#   vpc_security_group_ids = [data.aws_security_group.mysg.id]
#   key_name = var.key_name
#   tags = {
#     Name = local.instance_name
#   }
# } 

# variable "ami_id" {
#   default = "ami-0c398cb65a93047f2"
# }
# variable "instance_type" {
#   default = "t3.micro"
# }
# variable "key_name" {
#   default = "id_rsa"
# }
# variable "vpc_id" {
#   default = "vpc-082c0ea21bec713f1"
# }
# output "instance_public_ip" {
#   value = aws_instance.myinstance.public_ip
# }
# output "instance_id" {
#   value = aws_instance.myinstance.id
# }