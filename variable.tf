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