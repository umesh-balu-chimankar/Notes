# variable "ami_id" {
#   default = "ami-02b8269d5e85954ef"
#   description = "this is my new ami id"
# }
# variable "instance_type" {
#   default = "t3.micro"
# }
# variable "key_name" {
#   default = "id_rsa_key"
# }
# variable "availability_zone" {
#   default = "ap-south-1b"
# }
# variable "vpc_id" {
#   default = "vpc-0fc56b6da92c7716b"
# }

variable "region" {
  default = "us-east-1"
}
variable "project" {
  default = "marks"
}
variable "vpc_cidr" {
  default = "10.0.0.0/16"
}
variable "private_cidr" {
  default = "10.0.0.0/24"
}
variable "public_cidr" {
  default = "10.0.1.0/24"
}
variable "environment" {
  default = "devops"
}
variable "instance_count" {
  default = "2"
}
variable "image_id" {
  default = "ami-0ecb62995f68bb549"
}
variable "key_pair" {
  default = "id_rsa"
}
variable "instance_type" {
  default = "t3.micro"
}

