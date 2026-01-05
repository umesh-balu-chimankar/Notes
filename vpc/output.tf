output "vpc_id" {
  description = "VPC ID (aws_vpc.myvpc)"
  value       = aws_vpc.myvpc.id
}

output "public_subnet_id" {
  description = "Public Subnet ID (aws_subnet.pubsubnet)"
  value       = aws_subnet.pubsubnet.id
}

output "private_subnet_id" {
  description = "Private Subnet ID (aws_subnet.pvtsubnet)"
  value       = aws_subnet.pvtsubnet.id
}

output "internet_gateway_id" {
  description = "Internet Gateway ID (aws_internet_gateway.igw)"
  value       = aws_internet_gateway.igw.id
}

output "public_route_table_id" {
  description = "Public Route Table ID (aws_route_table.public_rt)"
  value       = aws_route_table.public_rt.id
}
