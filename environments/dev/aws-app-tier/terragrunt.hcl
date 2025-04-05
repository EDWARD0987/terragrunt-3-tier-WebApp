terraform {
  source = "../../../modules/app-tier"  # Adjust if necessary
}

include {
  path = find_in_parent_folders("root.hcl")
}

inputs = {
  environment    = "dev"
  app_name       = "dev-app"
  instance_type  = "t3.medium"
  subnet_ids     =["subnet-0f25e0b51c1f49cb9", "subnet-0ff6ef8ee6908b8e3"]

  tags = {
    Owner       = "Edward"
    Project     = "Three-Tier Web App"
    Environment = "dev"
    CostCenter  = "Development"
  }
}