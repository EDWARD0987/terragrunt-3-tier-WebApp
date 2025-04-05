#This ensures Terraform state files are stored securely in S3, preventing conflicts between environments.


remote_state {
  backend = "s3"
  config = {
    bucket         = "my-terraform-state"
    key            = "${path_relative_to_include()}/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
    dynamodb_table = "terraform-locks"
  }
}

generate "provider" {
  path      = "provider.tf"
  contents  = <<EOF
provider "aws" {
  region = "us-east-1"
}
EOF
}


inputs = {
  aws_region        = "us-east-1"
  vpc_id            = "vpc-0e332f3b9d2eb8bf3"
  subnet_ids        = ["subnet-0f25e0b51c1f49cb9", "subnet-0ff6ef8ee6908b8e3"]
  ami_id            = "ami-00a929b66ed6e0de6"
  instance_type     = "t2.micro"
  min_instances     = 2
  max_instances     = 5
  desired_instances = 3
  launch_template   = {
    name_prefix      = "web-launch-template"
    version          = "$Latest"
    associate_public_ip = true

  common_tags = {
    Owner       = "Edward"
    Project     = "Three-Tier Web App"
    environment = "${basename(path_relative_to_include())}"  # Tags based on environment
  }
  }
  

}