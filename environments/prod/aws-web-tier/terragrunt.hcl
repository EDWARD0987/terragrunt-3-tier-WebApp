terraform {
  source = "../../../modules/web-tier"  # Adjust if necessary
}

include {
  path = find_in_parent_folders("root.hcl")
}

inputs = {
  environment    = "dev"
  web_name       = "dev-web"
  instance_type  = "t3.micro"
  subnet_ids     =["subnet-0f25e0b51c1f49cb9", "subnet-0ff6ef8ee6908b8e3"]
  web_ports      = [80, 443]

  tags = {
    Owner       = "Edward"
    Project     = "Three-Tier Web App"
    Environment = "dev"
    CostCenter  = "Development"
  }
}