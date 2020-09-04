# -------------------------------------------
# Create an External ALB for the applications 
# -------------------------------------------
# Security group for alb
resource "aws_security_group" "ealb_sg" {
  name        = "${var.project_name}-Ext-LB-SG"
  description = "load balancer security group"
  vpc_id      = aws_vpc.devops_vpc.id

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow all outbound traffic.
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "devops_Ent_LB_SG"
  }
}

# Application Load Balancer 
resource "aws_lb" "ealb" {
  name               = "${var.project_name}-ASG-EALB"
  internal           = false
  load_balancer_type = "application"
  subnets            = [aws_subnet.devops-pub-2a.id, aws_subnet.devops-pub-2b.id, aws_subnet.devops-pub-2c.id]
  security_groups    = [aws_security_group.ealb_sg.id]

  tags = {
    name = "devops_External_ALB"
  }
}

resource "aws_lb_target_group" "external_alb_tg_app1" {
  name     = "${var.project_name}-Int-ALB-TG-App1"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.devops_vpc.id

  tags = {
    name = "devops_Ext_ALB_TG_App1"
  }

  health_check {
    path = "/"
    port = "traffic-port"
  }
}

resource "aws_lb_listener" "external_alb_listener" {
  load_balancer_arn = aws_lb.ealb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    target_group_arn = aws_lb_target_group.external_alb_tg_app1.arn
    type             = "forward"
  }
}
resource "aws_lb_listener_rule" "external_alb_rules" {
  listener_arn = aws_lb_listener.external_alb_listener.arn

  priority = 100

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.external_alb_tg_app1.arn
  }
  condition {
    path_pattern {
      values = ["/app1/*"]
    }
  }
}
