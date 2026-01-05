variable "aws_region" {
  default = "ap-south-1"
}

variable "vpc_id" {}

variable "public_subnets" {
  type = list(string)
}

variable "ami_id" {}

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

variable "bucket_name" {}

variable "upload_file" {
  description = "Local file path to upload to S3"
}
