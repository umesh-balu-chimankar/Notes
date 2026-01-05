output "pvt_subnet_id" {
  value = aws_subnet.pvt-subnet.id
}
output "pub_subnet_id" {
  value = aws_subnet.pub-subnet.id
}
output "vpc_id" {
  value = aws_vpc.myvpc.id
}