output "asg_name" {
  value = aws_autoscaling_group.app_asg.name
}

output "iam_role_arn" {
  value = aws_iam_role.app_role.arn
}