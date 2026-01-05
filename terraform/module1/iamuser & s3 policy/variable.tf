variable "aws_region" {
  description = "AWS region"
  default     = "eu-west-3"
}

variable "iam_user_name" {
  description = "IAM user name"
  default     = "s3-access-user"
}

variable "s3_bucket_name" {
  description = "Globally unique S3 bucket name"
  default     = "terraform-cd-bucket-12345"
}

variable "environment" {
  description = "Environment name"
  default     = "Dev"
}
