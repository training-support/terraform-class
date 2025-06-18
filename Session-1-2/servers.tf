resource "aws_launch_template" "example-web-server" {
  image_id = "ami-0f918f7e67a3323f0"
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.web-server-group.id]

  user_data = "${base64encode(data.template_file.test.rendered)}" 

  lifecycle {
    create_before_destroy = true
  }

}

data "template_file" "test" {
  template = <<-EOF
  #!/bin/bash
  echo "Hello, World" > index.html
  nohup busybox httpd -f -p ${var.server_port} &
  EOF
}

resource "aws_autoscaling_group" "web-server-scaling-group" {
  launch_template {
      name = aws_launch_template.example-web-server.name
  }

  vpc_zone_identifier = data.aws_subnets.default.ids

  target_group_arns = [aws_lb_target_group.asg.arn]
  health_check_type = "ELB"

  min_size = 2
  max_size = 10

  tag {
    key = "Name"
    value = "terraform-asg-example"
    propagate_at_launch = true
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

variable "server_port" {
  description = "This is the port the server will listen on."
  type = number
  default = 8080
}

output "alb_dns_name" {
  value = aws_lb.web-server-lb.dns_name
  description = "The domain of the load balancer"
}
