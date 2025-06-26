output "alb_dns_name" {
  value = aws_lb.web-server-lb.dns_name
  description = "The domain name of the load balancer"
}

output "asg_name" {
  value = aws_autoscaling_group.web-server-scaling-group.name
  description = "The name of the ASG"
}

output "alb_security_group_id" {
  value = aws_security_group.alb.id
  description = "The ALB's Security Group ID"
}
