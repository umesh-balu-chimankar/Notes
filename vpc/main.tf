provider "aws" {
  region = "ap-south-1"
}

resource "aws_vpc" "myvpc" {
  cidr_block           = "10.0.0.0/16"

  tags = {
    Name = "prod-vpc"
  }
}
resource "aws_subnet" "pvtsubnet" {
  vpc_id                  = aws_vpc.myvpc.id
  cidr_block              = "10.0.0.0/20"
  availability_zone       = "ap-south-1a"
  map_public_ip_on_launch = false

  tags = {
    Name = "private-subnet"
  }
}
resource "aws_subnet" "pubsubnet" {
  vpc_id                  = aws_vpc.myvpc.id
  cidr_block              = "10.0.16.0/20"
  availability_zone       = "ap-south-1b" 
  map_public_ip_on_launch = true

  tags = {
    Name = "public-subnet"
  }
}
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.myvpc.id

  tags = {
    Name = "prod-igw"
  }
}
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.myvpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
}
resource "aws_route_table_association" "public_assoc" {
  subnet_id      = aws_subnet.pubsubnet.id
  route_table_id = aws_route_table.public_rt.id
}



