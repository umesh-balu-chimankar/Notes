resource "aws_instance" "my-instance" {
  ami = var.image_id
  instance_type = var.instance_type
  key_name = var.key_pair
  vpc_security_group_ids = var.sg_ids
  tags ={
    Name = "${var.project}-instance"
    env = var.env
  }
  subnet_id = var.subnet_id
}
