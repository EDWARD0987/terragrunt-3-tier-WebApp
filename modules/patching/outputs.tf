

output "patch_baseline_id" {
  value = aws_ssm_patch_baseline.this.id
}

output "patch_group_name" {
  value = aws_ssm_patch_group.this.patch_group
}