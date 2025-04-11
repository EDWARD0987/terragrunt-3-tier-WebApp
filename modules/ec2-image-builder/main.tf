resource "aws_imagebuilder_image_pipeline" "example_pipeline" {
  name                          = var.pipeline_name
  description                   = var.pipeline_description
  image_recipe_arn              = aws_imagebuilder_image_recipe.example_recipe.arn
  infrastructure_configuration_arn = aws_imagebuilder_infrastructure_configuration.example_infra.arn
}

resource "aws_imagebuilder_image_recipe" "example_recipe" {
  name          = var.recipe_name
  parent_image  = var.base_ami
  version       = var.recipe_version

  dynamic "component" {
    for_each = var.image_components
    content {
      component_arn = component.value
    }
  }
}

resource "aws_imagebuilder_infrastructure_configuration" "example_infra" {
  name                    = var.infra_name
  instance_types          = var.instance_types
  security_group_ids      = [var.security_group_id]
  subnet_id               = var.subnet_id
  #iam_role_arn            = aws_iam_role.image_builder_role.arn
  instance_profile_name   = aws_iam_instance_profile.image_builder_profile.name
}


resource "aws_iam_instance_profile" "image_builder_profile" {
  name = "EC2ImageBuilderInstanceProfile"
  role = aws_iam_role.image_builder_role.name
}
