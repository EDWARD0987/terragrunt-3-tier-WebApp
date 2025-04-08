include {
  path = find_in_parent_folders("root.hcl")  # Ensures access to global configs
}

terraform {
  source = "../../modules/web-tier"  # Path to web-tier module
}




inputs = {
  aws_region        = "us-east-1"
  vpc_id            = "vpc-0e332f3b9d2eb8bf3"
  subnet_ids        = ["subnet-0ff6ef8ee6908b8e3", "subnet-0f25e0b51c1f49cb9"]
  instance_type     = "t2.micro"
  min_instances     = 2
  max_instances     = 5
  desired_instances = 3
 

  launch_template   = {
    name_prefix          = "web-launch-template"
    version              = "$Latest"
    associate_public_ip  = true
  }

  common_tags = {
    Owner       = "Edward"
    Project     = "Three-Tier Web App"
    Environment = "dev"
    CostCenter  = "Development"
  }
}