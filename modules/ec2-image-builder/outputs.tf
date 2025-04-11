output "image_pipeline_arn" {
  description = "ARN of the EC2 Image Builder pipeline"
  value       = aws_imagebuilder_image_pipeline.example_pipeline.arn
}

output "image_recipe_arn" {
  description = "ARN of the Image Recipe"
  value       = aws_imagebuilder_image_recipe.example_recipe.arn
}

output "infrastructure_configuration_arn" {
  description = "ARN of the Image Builder Infrastructure Configuration"
  value       = aws_imagebuilder_infrastructure_configuration.example_infra.arn
}

output "instance_profile_name" {
  description = "Name of the IAM instance profile assigned to EC2 Image Builder"
  value       = aws_iam_instance_profile.image_builder_profile.name
}