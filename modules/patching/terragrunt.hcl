

terraform {
  source = "../../../modules/patching"
}

inputs = {
  patch_baseline_name = "dev-patch-baseline"
  patch_group_name    = "dev-patch-group"
  operating_system    = "AMAZON_LINUX_2"
  approve_after_days  = 7
  environment         = "dev"
}