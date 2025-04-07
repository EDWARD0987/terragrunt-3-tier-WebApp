
# Patch Baseline
resource "aws_ssm_patch_baseline" "this" {
  name             = var.patch_baseline_name
  description      = "Patch baseline for updates"
  approved_patches = var.approved_patches
  operating_system = var.operating_system

  approval_rule {
    patch_filter {
      key    = "PRODUCT"
      values = var.patch_filter_products
    }
    approve_after_days = var.approve_after_days
  }

  tags = {
    Environment = var.environment
  }
}

# Patch Group
resource "aws_ssm_patch_group" "this" {
  baseline_id = aws_ssm_patch_baseline.this.id
  patch_group = var.patch_group_name


#   tags = {
#     Name        = "Patch Group"
#     Environment = var.environment
#   }
}

# Maintenance Window (Optional)
resource "aws_ssm_maintenance_window" "this" {
  name                      = var.maintenance_window_name
  schedule                  = var.maintenance_window_schedule
  duration                  = var.maintenance_window_duration
  cutoff                    = var.maintenance_window_cutoff
  allow_unassociated_targets = true

  tags = {
    Environment = var.environment
  }
}
