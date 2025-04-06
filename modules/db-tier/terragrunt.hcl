# Defines inputs for modular infrastructure management

terraform {
  source = "../../modules/app-tier"
}

include {
  path = find_in_parent_folders()
}

inputs = {
  aws_region        = "us-east-1"
  vpc_id            = "vpc-0e332f3b9d2eb8bf3"
  subnet_ids        = ["subnet-0f25e0b51c1f49cb9", "subnet-0ff6ef8ee6908b8e3"]
  ami_id            = "ami-00a929b66ed6e0de6"
  instance_type     = "t3.medium"
  min_instances     = 2
  max_instances     = 5
  desired_instances = 3
  web_tier_cidr_blocks = ["10.0.1.0/24"]
}
