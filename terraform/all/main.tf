####################
# Provider
####################
provider "aws" {
  region = var.aws_region
}

####################
# IAM Role (EC2)
####################
resource "aws_iam_role" "ec2_role" {
  name = "asg-ec2-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
      Action = "sts:AssumeRole"
    }]
  })
}

####################
# IAM Policy (S3 + CloudWatch)
####################
resource "aws_iam_policy" "ec2_policy" {
  name = "asg-ec2-policy"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action   = ["s3:*"]
        Resource = "*"
      },
      {
        Effect   = "Allow"
        Action   = ["cloudwatch:*", "logs:*"]
        Resource = "*"
      }
    ]
  })
}

####################
# Attach Policy
####################
resource "aws_iam_role_policy_attachment" "attach" {
  role       = aws_iam_role.ec2_role.name
  policy_arn = aws_iam_policy.ec2_policy.arn
}

####################
# Instance Profile
####################
resource "aws_iam_instance_profile" "profile" {
  name = "asg-instance-profile"
  role = aws_iam_role.ec2_role.name
}

####################
# Security Group
####################
resource "aws_security_group" "asg_sg" {
  name   = "asg-sg"
  vpc_id = var.vpc_id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

####################
# Launch Template
####################
resource "aws_launch_template" "lt" {
  name_prefix   = "web-lt-"
  image_id      = var.ami_id
  instance_type = var.instance_type
  key_name      = var.key_name

  iam_instance_profile {
    name = aws_iam_instance_profile.profile.name
  }

  vpc_security_group_ids = [aws_security_group.asg_sg.id]

  user_data = base64encode(<<EOF
#!/bin/bash
yum install -y httpd aws-cli
systemctl start httpd
systemctl enable httpd
echo "Hello from Auto Scaling" > /var/www/html/index.html
EOF
)
}

####################
# Target Group
####################
resource "aws_lb_target_group" "tg" {
  name     = "asg-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  health_check {
    path = "/"
  }
}

####################
# Application Load Balancer
####################
resource "aws_lb" "alb" {
  name               = "asg-alb"
  load_balancer_type = "application"
  security_groups    = [aws_security_group.asg_sg.id]
  subnets            = var.public_subnets
}

####################
# Listener
####################
resource "aws_lb_listener" "listener" {
  load_balancer_arn = aws_lb.alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tg.arn
  }
}

####################
# Auto Scaling Group
####################
resource "aws_autoscaling_group" "asg" {
  desired_capacity    = var.desired_capacity
  min_size            = var.min_size
  max_size            = var.max_size
  vpc_zone_identifier = var.public_subnets
  target_group_arns  = [aws_lb_target_group.tg.arn]

  launch_template {
    id      = aws_launch_template.lt.id
    version = "$Latest"
  }

  tag {
    key                 = "Name"
    value               = "asg-instance"
    propagate_at_launch = true
  }
}

####################
# CloudWatch Alarm
####################
resource "aws_cloudwatch_metric_alarm" "cpu_alarm" {
  alarm_name          = "cpu-high"
  comparison_operator = "GreaterThanThreshold"
  threshold           = 70
  evaluation_periods  = 2
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = 120
  statistic           = "Average"

  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.asg.name
  }
}

####################
# S3 Bucket
####################
resource "aws_s3_bucket" "bucket" {
  bucket = var.bucket_name
}

####################
# S3 Upload
####################
resource "aws_s3_object" "upload" {
  bucket = aws_s3_bucket.bucket.id
  key    = "sample.txt"
  source = var.upload_file
}
