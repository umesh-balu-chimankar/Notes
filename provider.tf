provider "aws" {
  region = "ap-south-1"
}
resource "aws_security_group" "mysg" {
  name        = "${var.project}-mysg"
  description = "Allow httpd service"
  vpc_id      = module.my_vpc_module.vpc_id

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
    Name = "${var.project}-mysg"
  }
  depends_on = [
    module.my_vpc_module
  ]
}
module "my_vpc_module" {
    source = "./modules/vpc"
    project = var.project
    vpc_cidr = var.vpc_cidr
    pvt_subnet_cidr = var.private_cidr
    pub_subnet_cidr = var.public_cidr
    env = var.environment
}

module "my_instance" {
  source = "./modules/instance"
  count = var.instance_count
  image_id = var.image_id 
  key_pair = var.key_pair
  instance_type = var.instance_type
  project = var.project
  env = var.environment
  subnet_id = module.my_vpc_module.pub_subnet_id
  sg_ids = [aws_security_group.mysg.id]
}



