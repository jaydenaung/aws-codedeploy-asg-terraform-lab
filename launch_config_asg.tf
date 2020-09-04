
resource "aws_launch_configuration" "web_launch_conf" {
  name_prefix          = "devops-"
  image_id             = var.ubuntu_18_sydney
  iam_instance_profile = aws_iam_instance_profile.ec2_cd_instance_profile.name
  instance_type               = "t2.micro"
  key_name                    = var.key_name
  security_groups             = [aws_security_group.asg_web_sg.id]
  associate_public_ip_address = true

  user_data = file("codedeploy_agent_install.sh")

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "devops_web_asg" {
  name                 = "devops_web_asg"
  launch_configuration = aws_launch_configuration.web_launch_conf.name
  min_size             = 3
  desired_capacity     = 3
  max_size             = 5
  health_check_type    = "EC2"
  availability_zones   = ["ap-southeast-2a", "ap-southeast-2b", "ap-southeast-2c"]
  target_group_arns = [
    aws_lb_target_group.external_alb_tg_app1.arn
  ]
  enabled_metrics = [
    "GroupMinSize",
    "GroupMaxSize",
    "GroupDesiredCapacity",
    "GroupInServiceInstances",
    "GroupTotalInstances"
  ]

  metrics_granularity = "1Minute"

  vpc_zone_identifier = [
    aws_subnet.devops-pub-2a.id,
    aws_subnet.devops-pub-2b.id,
    aws_subnet.devops-pub-2c.id
  ]

  lifecycle {
    create_before_destroy = true
  }

}

#ASG Scale-up Policy

resource "aws_autoscaling_policy" "devops_web_asg_policy_up" {
  name                   = "devops_web_asg_policy_up"
  scaling_adjustment     = 1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
  autoscaling_group_name = aws_autoscaling_group.devops_web_asg.name
}

resource "aws_cloudwatch_metric_alarm" "devops_web_asg_cpu_alarm_up" {
  alarm_name          = "devops_web_asg_cpu_alarm_up"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "120"
  statistic           = "Average"
  threshold           = "80"

  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.devops_web_asg.name
  }

  alarm_description = "This metric monitor EC2 instance CPU utilization"
  alarm_actions     = ["${aws_autoscaling_policy.devops_web_asg_policy_up.arn}"]
}

#ASG Scale-down Policy

resource "aws_autoscaling_policy" "devops_web_asg_policy_down" {
  name                   = "devops_web_asg_policy_down"
  scaling_adjustment     = -1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
  autoscaling_group_name = aws_autoscaling_group.devops_web_asg.name
}

resource "aws_cloudwatch_metric_alarm" "devops_web_asg_cpu_alarm_down" {
  alarm_name          = "devops_web__asg_cpu_alarm_down"
  comparison_operator = "LessThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "120"
  statistic           = "Average"
  threshold           = "20"

  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.devops_web_asg.name
  }

  alarm_description = "This metric monitor EC2 instance CPU utilization"
  alarm_actions     = [aws_autoscaling_policy.devops_web_asg_policy_down.arn]
}


#Security Group for ASG 

resource "aws_security_group" "asg_web_sg" {
  name        = "asg_web_sg"
  description = "Allow HTTP inbound connections"
  vpc_id      = aws_vpc.devops_vpc.id

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

  tags = {
    Name = "devops_SG_Web_Security_Group"
  }
}