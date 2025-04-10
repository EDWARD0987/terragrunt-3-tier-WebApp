

resource "aws_ssm_patch_baseline" "this" {
  name             = var.patch_baseline_name
  description      = "Automated Patch Baseline"
  operating_system = var.operating_system

  approval_rule {
    patch_filter {
      key    = "CLASSIFICATION"  # 
      values = ["Security"]

    }
    approve_after_days = var.approve_after_days
  }

  tags = {
    Environment = var.environment
  }
}

resource "aws_ssm_patch_group" "this" {
  baseline_id = aws_ssm_patch_baseline.this.id
  patch_group = var.patch_group_name
}

# resource "aws_ssm_patch_group" "this" {
#   baseline_id = aws_ssm_patch_baseline.this.id
#   patch_group = "web-patching"
# }

resource "aws_ssm_maintenance_window" "this" {
  name     = "patching-window"
  schedule = "cron(0 3 ? * SUN *)"  # Runs every Sunday at 3 AM
  duration = 2
  cutoff   = 1
}