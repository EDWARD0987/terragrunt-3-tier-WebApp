terraform {
  source = "../../../modules/ec2-image-builder"
}

inputs = {
  pipeline_name       = "dev-pipeline"
  pipeline_description = "Development pipeline for AMI creation"
  recipe_name         = "dev-recipe"
  base_ami            = "ami-xxxxxxxxxxxxxxxxx"
  recipe_version      = "1.0.1"
  instance_types      = ["t3.medium"]
  security_group_id   = "sg-xxxxxxxxxxxx"
  subnet_id           = "subnet-xxxxxxxxxxxx"
  iam_role_arn        = "arn:aws:iam::123456789012:role/ImageBuilderRole"
  instance_profile_name = "aws_iam_instance_profile.image_builder_profile.name"
  #instance_profile_name = "EC2ImageBuilderInstanceProfile"
  image_components    = [
    "arn:aws:imagebuilder:us-east-1:aws:component/install-nginx/1.0.0",
    "arn:aws:imagebuilder:us-east-1:aws:component/configure-ssh/1.0.0"
  ]
}