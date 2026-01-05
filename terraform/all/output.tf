output "alb_dns_name" {
  value = aws_lb.alb.dns_name
}

output "s3_bucket_name" {
  value = aws_s3_bucket.bucket.id
}

output "autoscaling_group_name" {
  value = aws_autoscaling_group.asg.name
}
