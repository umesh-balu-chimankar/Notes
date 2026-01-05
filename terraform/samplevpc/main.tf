terraform {
  backend "s3" {
    bucket = "batch151234"
    region = "us-east-1"
    key = "tfstate"
  }
}
provider "aws" {
  region = var.region
}
resource "aws_vpc" "my-vpc" {
  cidr_block       = var.vpc-cidr
  tags = {
    Name = "${var.project}-vpc"
    env = "var.env"
  }
}
resource "aws_subnet" "pvt-subnet" {
  vpc_id     = aws_vpc.my-vpc.id
  cidr_block = var.pvt-cidr
  availability_zone = var.pvt-az
  tags = {
    Name = "${var.project}-pvt-sub"
  }
}
resource "aws_subnet" "pub-subnet" {
  vpc_id     = aws_vpc.my-vpc.id
  cidr_block = var.pub-cidr
  availability_zone = var.pub-az
  tags = {
    Name = "${var.project}-pub-sub"
  }
  map_public_ip_on_launch = true
}
resource "aws_internet_gateway" "my-igw" {
  vpc_id = aws_vpc.my-vpc.id

  tags = {
    Name = "${var.project}-igw"
  }
}
resource "aws_default_route_table" "myrout" {
  default_route_table_id = aws_vpc.my-vpc.default_route_table_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my-igw.id
  }

  tags = {
    Name = "${var.project}-myrout"
  }
}
resource "aws_security_group" "sg1" {
  name        = "${var.project}-sg"
  description = "Allow httpd service"
  vpc_id      = aws_vpc.my-vpc.id

  ingress {
    protocol         = "TCP"
    from_port        = 80
    to_port          = 80
    cidr_blocks      = ["0.0.0.0/0"]
  }
  ingress {
    protocol         = "TCP"
    from_port        = 22
    to_port          = 22
    cidr_blocks      = ["0.0.0.0/0"]
  }
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.project}-sg"
  }
}
resource "aws_instance" "pvt-instance" {
  ami = var.ami
  instance_type = var.instance_type
  key_name      = var.key_pair
  tags          = var.pvt-tags
  subnet_id     = aws_subnet.pvt-subnet.id
  vpc_security_group_ids = [aws_security_group.sg1.id ]
}

resource "aws_instance" "pub-instance" {
  ami = var.ami
  instance_type = var.instance_type
  key_name      = var.key_pair
  tags          = var.pub-tags
  subnet_id     = aws_subnet.pub-subnet.id
  vpc_security_group_ids = [aws_security_group.sg1.id]

  user_data = <<-EOF
  #!/bin/bash
  sudo apt-get update
  sudo apt-get install apache2 -y
  sudo systemctl start apache2
  sudo systemctl enable apache2
  echo "<h1>welcome to terraform</h1>" > /var/www/html/index.html
  EOF

 depends_on = [aws_security_group.sg1]
}
