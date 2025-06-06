terraform {
  source = "../../../modules/ec2-image-builder"
}


inputs = {
  security_group_id = dependency.security.outputs.sg_id
  subnet_id         = dependency.vpc.outputs.subnet_id
  image_name        = "example-image"
}


# dependencies {
#   paths = ["../../ec2-image-builder"]
# }




# inputs = {
#   pipeline_name       = "dev-pipeline"
#   pipeline_description = "Development pipeline for AMI creation"
#   recipe_name         = "dev-recipe"
#   base_ami            = "ami-00a929b66ed6e0de6"
#   recipe_version      = "1.0.1"
#   instance_types      = ["t3.medium"]
#   #security_group_id   =  [aws_security_group.web_sg.id]
#   security_group_id    = [aws_security_group.image_builder_sg.id]
#   security_group_id = dependency.ec2-image-builder.outputs.image_builder_sg_id

 
#   subnet_id           = "subnet-0f25e0b51c1f49cb9"
#   iam_role_arn        = "arn:aws:iam::123456789012:role/ImageBuilderRole"
#   instance_profile_name = "aws_iam_instance_profile.image_builder_profile.name"
#   #instance_profile_name = "EC2ImageBuilderInstanceProfile"
#   image_components    = [
#     "arn:aws:imagebuilder:us-east-1:aws:component/install-nginx/1.0.0",
#     "arn:aws:imagebuilder:us-east-1:aws:component/configure-ssh/1.0.0"
#   ]
# }

# inputs = {
#   pipeline_name         = "dev-pipeline"
#   pipeline_description  = "Development pipeline for AMI creation"
#   recipe_name           = "dev-recipe"
#   base_ami              = "ami-00a929b66ed6e0de6"
#   recipe_version        = "1.0.1"
#   instance_types        = ["t3.medium"]
#   security_group_id     = dependency.security-group.outputs.security_group_id  
#   subnet_id             = "subnet-0f25e0b51c1f49cb9"
#   iam_role_arn          = "arn:aws:iam::123456789012:role/ImageBuilderRole"
#   instance_profile_name = dependency.iam.outputs.instance_profile_name  

#   image_components = [
#     "arn:aws:imagebuilder:us-east-1:aws:component/install-nginx/1.0.0",
#     "arn:aws:imagebuilder:us-east-1:aws:component/configure-ssh/1.0.0"
#   ]
# }