#This ensures Terraform state files are stored securely in S3, preventing conflicts between environments.

# Stores Terraform state files in AWS S3 ( bucket) => elinks-terragrunt-demo
# Uses ${path_relative_to_include()} to dynamically structure state paths per environment.
remote_state {
  backend = "s3"
  config = {
    bucket         = "elinks-terragrunt-demo"
    key            = "${path_relative_to_include()}/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
    dynamodb_table = "terraform-locks"
  }
}


# Dynamically generates a Terraform AWS provider (provider.tf) inside the Terragrunt-managed modules.
# Uses ,(if_exists ="skip") meaning Terragrunt won’t overwrite an existing  file
generate "provider" {
  path      = "provider.tf"
  if_exists = "skip"   # Avoid overwriting an existing provider.tf file
  contents  = <<EOF
provider "aws" {
  region = "us-east-1"
}
EOF
}


# Passes configuration variables to Terraform (vpc_id,subnets ,AMI ,instance_type , etc.)
# launch template Defines an EC2 Launch Template with the latest version
# common_tags Sets default tags for all AWS resources
# Uses "${basename(path_relative_to_include())}", ensuring different environments (like dev and prod) automatically apply the correct tag.
inputs = {
  aws_region        = "us-east-1"
  vpc_id            = "vpc-0e332f3b9d2eb8bf3"
  subnet_ids        = ["subnet-0f25e0b51c1f49cb9", "subnet-0ff6ef8ee6908b8e3", "subnet-068ee5276b119b996"]
  ami_id            = "ami-00a929b66ed6e0de6"
  instance_type     = "t2.micro"
  instance_class    = "db.t3.micro"
  iam_instance_profile = "SSMRoleForEC2"
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


