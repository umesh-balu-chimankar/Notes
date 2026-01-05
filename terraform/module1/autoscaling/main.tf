#Security Group
resource "aws_security_group" "asg_sg" {
name = "asg-sg"
vpc_id = var.vpc_id


ingress {
from_port = 80
to_port = 80
protocol = "tcp"
cidr_blocks = ["0.0.0.0/0"]
}


ingress {
from_port = 22
to_port = 22
protocol = "tcp"
cidr_blocks = ["0.0.0.0/0"]
}


egress {
from_port = 0
to_port = 0
protocol = "-1"
cidr_blocks = ["0.0.0.0/0"]
}
}

#Launch Template
resource "aws_launch_template" "web_lt" {
name_prefix = "web-lt-"
image_id = var.ami_id
instance_type = var.instance_type
key_name = var.key_name


vpc_security_group_ids = [aws_security_group.asg_sg.id]


user_data = base64encode(<<EOF
#!/bin/bash
yum install -y httpd
systemctl start httpd
systemctl enable httpd
echo "Auto Scaling Instance" > /var/www/html/index.html
EOF
)
}

#Target Group
resource "aws_lb_target_group" "tg" {
name = "asg-tg"
port = 80
protocol = "HTTP"
vpc_id = var.vpc_id


health_check {
path = "/"
}
}

#Application Load Balancer
resource "aws_lb" "alb" {
name = "asg-alb"
internal = false
load_balancer_type = "application"
security_groups = [aws_security_group.asg_sg.id]
subnets = var.public_subnets
}

#Listener
resource "aws_lb_listener" "listener" {
load_balancer_arn = aws_lb.alb.arn
port = 80
protocol = "HTTP"


default_action {
type = "forward"
target_group_arn = aws_lb_target_group.tg.arn
}
}

#Auto Scaling Group
resource "aws_autoscaling_group" "asg" {
desired_capacity = var.desired_capacity
min_size = var.min_size
max_size = var.max_size
vpc_zone_identifier = var.public_subnets


launch_template {
id = aws_launch_template.web_lt.id
version = "$Latest"
}


target_group_arns = [aws_lb_target_group.tg.arn]


tag {
key = "Name"
value = "autoscaling-instance"
propagate_at_launch = true
}
}

#Scaling Policy (CPU Based)
resource "aws_autoscaling_policy" "cpu_scale_up" {
name = "cpu-scale-up"
scaling_adjustment = 1
adjustment_type = "ChangeInCapacity"
cooldown = 300
autoscaling_group_name = aws_autoscaling_group.asg.name
}

#CloudWatch Alarm
resource "aws_cloudwatch_metric_alarm" "cpu_alarm_high" {
alarm_name = "cpu-high"
comparison_operator = "GreaterThanThreshold"
evaluation_periods = 2
metric_name = "CPUUtilization"
namespace = "AWS/EC2"
period = 120
statistic = "Average"
threshold = 70


dimensions = {
AutoScalingGroupName = aws_autoscaling_group.asg.name
}

alarm_actions = [aws_autoscaling_policy.cpu_scale_up.arn]
}

