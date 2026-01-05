################################
# Provider
################################
provider "aws" {
  region = var.aws_region
}

################################
# IAM User
################################
resource "aws_iam_user" "my_iam_user" {
  name = var.iam_user_name
  path = "/"

  tags = {
    Name = var.iam_user_name
  }
}

################################
# S3 Bucket
################################
resource "aws_s3_bucket" "cd_bucket" {
  bucket = var.s3_bucket_name

  tags = {
    Name        = "terraform-s3-bucket"
    Environment = var.environment
  }
}

################################
# IAM Policy for S3 Access
################################
resource "aws_iam_policy" "s3_access_policy" {
  name        = "s3-access-policy"
  description = "Allow limited access to a specific S3 bucket"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "s3:ListBucket"
        ]
        Resource = aws_s3_bucket.cd_bucket.arn
      },
      {
        Effect = "Allow"
        Action = [
          "s3:GetObject",
          "s3:PutObject"
        ]
        Resource = "${aws_s3_bucket.cd_bucket.arn}/*"
      }
    ]
  })
}

################################
# Attach Policy to IAM User
################################
resource "aws_iam_user_policy_attachment" "s3_access_attachment" {
  user       = aws_iam_user.my_iam_user.name
  policy_arn = aws_iam_policy.s3_access_policy.arn
}
