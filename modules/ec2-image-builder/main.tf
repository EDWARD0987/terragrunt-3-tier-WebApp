# resource "aws_imagebuilder_recipe" "example" {
#   name         = "my-recipe"
#   version      = "1.0.0"
#   components   = [aws_imagebuilder_component.example.arn]
#   parent_image = data.aws_ami.ubuntu.id
# }

# resource "aws_imagebuilder_component" "example" {
#   name         = "install-nginx"
#   version      = "1.0.0"
#   platform     = "Linux"
#   description  = "An example component to install NGINX"
#   data         = file("${path.module}/install-nginx.yaml")
# }

# resource "aws_imagebuilder_pipeline" "example" {
#   name                  = "my-pipeline"
#   image_recipe_arn      = aws_imagebuilder_recipe.example.arn
#   infrastructure_config = aws_imagebuilder_infrastructure.example.arn
# }

# resource "aws_imagebuilder_infrastructure" "example" {
#   name      = "my-infrastructure-config"
#   instance_types = ["t2.micro"]
#   subnet_id      = var.subnet_id
#   security_group_ids = [var.security_group_id]
#   sns_topic_arn      = aws_sns_topic.example.arn
# }

# resource "aws_subnet" "example" {
#   vpc_id            = aws_vpc.example.id
#   cidr_block        = "10.0.1.0/24"
#   availability_zone = "us-east-1a"
# }



