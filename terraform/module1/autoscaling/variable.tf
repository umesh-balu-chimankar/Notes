variable "vpc_id" {}


variable "public_subnets" {
type = list(string)
}


variable "ami_id" {
default = "ami-0f58b397bc5c1f2e8"
}


variable "instance_type" {
default = "t2.micro"
}


variable "key_name" {}


variable "desired_capacity" {
default = 2
}


variable "min_size" {
default = 1
}


variable "max_size" {
default = 4
}