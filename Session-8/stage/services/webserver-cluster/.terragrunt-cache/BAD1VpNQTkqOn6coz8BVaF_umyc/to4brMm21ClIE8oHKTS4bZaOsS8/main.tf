terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.0.0-beta3"
    }
  }
}

provider "aws" {
  region = "ap-south-2"
}

resource "aws_launch_template" "example-web-server" {
  image_id = "ami-06a3dc84cf2fde367"
  instance_type = "t3.micro"
  vpc_security_group_ids = [aws_security_group.web-server-group.id]

  user_data = base64encode(templatefile("${path.module}/user-data.sh", {
    server_port = var.server_port
    db_address = var.db_address
    db_port = var.db_port
  }))

  lifecycle {
    create_before_destroy = true
  }

}

resource "aws_autoscaling_group" "web-server-scaling-group" {
  launch_template {
      name = aws_launch_template.example-web-server.name
  }

  vpc_zone_identifier = data.aws_subnets.default.ids

  target_group_arns = [aws_lb_target_group.asg.arn]
  health_check_type = "ELB"

  min_size = var.min_size
  max_size = var.max_size

  tag {
    key = "Name"
    value = var.cluster_name
    propagate_at_launch = true
  }
  
}

resource "aws_security_group" "web-server-group" {
  name = "${var.cluster_name}-security-group"
}

resource "aws_security_group_rule" "allow_incoming_http" {
  type = "ingress"
  security_group_id = aws_security_group.web-server-group.id
  from_port = var.server_port
  to_port = var.server_port
  protocol = local.tcp_protocol
  cidr_blocks = local.all_ips
}

resource "aws_security_group" "alb" {
  name = "${var.cluster_name}-alb-security-group"
}

resource "aws_security_group_rule" "allow_inbound_http" {
  type = "ingress"
  security_group_id = aws_security_group.alb.id
  from_port = local.http_port
  to_port = local.http_port
  protocol = local.tcp_protocol
  cidr_blocks = local.all_ips
}

resource "aws_security_group_rule" "allow_all_outbound" {
  type = "egress"
  security_group_id = aws_security_group.alb.id
  from_port = local.any_port
  to_port = local.any_port
  protocol = local.any_protocol
  cidr_blocks = local.all_ips
}

resource "aws_lb" "web-server-lb" {
  name = "${var.cluster_name}-web-server-lb"
  load_balancer_type = "application"
  subnets = data.aws_subnets.default.ids
  security_groups = [aws_security_group.alb.id]
}

resource "aws_lb_listener" "web-server-lb-listener" {
  load_balancer_arn = aws_lb.web-server-lb.arn
  port = local.http_port
  protocol = "HTTP"

  default_action {
    type = "fixed-response"

    fixed_response {
      content_type = "text/plain"
      message_body = "404: Page Not Found"
      status_code = 404
    }
  }
}

resource "aws_lb_target_group" "asg" {
  name = "${var.cluster_name}-asg-target-group"
  port = var.server_port
  protocol = "HTTP"
  vpc_id = data.aws_vpc.default.id

  health_check {
    path = "/"
    protocol = "HTTP"
    matcher = "200"
    interval = 15
    timeout = 3
    healthy_threshold = 2
    unhealthy_threshold = 2
  }
}

resource "aws_lb_listener_rule" "asg" {
  listener_arn = aws_lb_listener.web-server-lb-listener.arn
  priority = 100

  condition {
    path_pattern {
      values = ["*"]
    }
  }

  action {
    type = "forward"
    target_group_arn = aws_lb_target_group.asg.arn
  }
}

data "aws_vpc" "default" {
  default = true
}

data "aws_subnets" "default" {
  filter {
    name = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}

locals {
  http_port = 80
  any_port = 0
  any_protocol = "-1"
  tcp_protocol = "tcp"
  all_ips = ["0.0.0.0/0"]
}
