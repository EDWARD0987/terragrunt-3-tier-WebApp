output "alb_dns" {
  value = aws_lb.web_alb.dns_name
}

output "asg_name" {
  value = aws_autoscaling_group.web_asg.name
}