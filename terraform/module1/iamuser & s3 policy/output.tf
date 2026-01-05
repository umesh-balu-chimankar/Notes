output "iam_user_name" {
  description = "IAM user created by Terraform"
  value       = aws_iam_user.my_iam_user.name
}

output "s3_bucket_name" {
  description = "S3 bucket name"
  value       = aws_s3_bucket.cd_bucket.bucket
}

output "s3_bucket_arn" {
  description = "S3 bucket ARN"
  value       = aws_s3_bucket.cd_bucket.arn
}

output "iam_policy_arn" {
  description = "IAM policy ARN"
  value       = aws_iam_policy.s3_access_policy.arn
}
