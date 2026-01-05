variable "region" {
    default = "us-east-1"
}
variable "vpc-cidr" {
  default = "10.0.0.0/16"
}
variable "pvt-cidr" {
  default = "10.0.0.0/24"
}
variable "pub-cidr" {
  default = "10.0.1.0/24"
}
variable "pvt-az"{
    default = "us-east-1a"
}
variable "pub-az"{
    default = "us-east-1b"
}
variable "project" {
  default = "cloud"
}
variable "instance_type" {
    description = "enter instance type"
    default = "t3.micro"
}
variable "ami" {
  default = "ami-0ecb62995f68bb549"
}
variable "key_pair" {
  default = "id_rsa"
}
variable "pvt-tags" {
  type = map
  default = {
    Name = "pvt-instance"
    env = "terraform-practice"
  }
}
variable "pub-tags" {
  type = map
  default = {
    Name = "pub-instance"
    env = "terraform-practice"
  }
}
