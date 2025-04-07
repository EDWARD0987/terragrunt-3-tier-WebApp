terraform {
  source = "../../modules/web-tier"
}

include {
  path = find_in_parent_folders()
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
  iam_instance_profile = "SSMRoleForEC2"
  launch_template   = {
    name_prefix      = "web-launch-template"
    version          = "$Latest"
    associate_public_ip = true
  }

}