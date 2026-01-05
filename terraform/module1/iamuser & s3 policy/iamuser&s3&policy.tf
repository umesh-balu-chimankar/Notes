# Create IAM user 

provider "aws" {
  region = "eu-west-3"  
}

resource "aws_iam_user" "my_iam_user" {
  name = "new"
  path = "/"
  tags = {
    Name = "new"
  } 
}

# Create s3 bucket 

resource "aws_s3_bucket" "CD" {
  bucket = var.s3-bucket-name
  tags = {
    Name        = "new-bucket"
    Environment = "Dev"
  }
}  

# Create s3 policy access above bucket 

resource "aws_iam_policy" "s3_access_policy" {
  name        = "s3_access_policy"
  description = "IAM policy for S3 bucket access"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect   = "Allow",
        Action   = [
          "s3:GetObject",
          "s3:PutObject",
          "s3:ListBucket",
        ],
        Resource = [
          aws_s3_bucket.CD.arn,
          "${aws_s3_bucket.CD.arn}/*",
        ],
      },
    ],
  })
}

# Attach s3 policy to user 

resource "aws_iam_user_policy_attachment" "s3_access_attachment" {
  user       = aws_iam_user.my_iam_user.name
  policy_arn = aws_iam_policy.s3_access_policy.arn
}

# variable Block

variable "s3-bucket-name" {
  default = "bucket-from-terraform"
}